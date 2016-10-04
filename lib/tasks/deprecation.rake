namespace :deprecation do
  desc 'Sends a deprecation email to users of short form budget planner. Pass params "prod" to actually send the email'
  task :short_forms, [:confirm] => :environment do |t, opts|
    BudgetPlanner::Budget
      .preload(:user)
      .find_each(batch_size: 50)
      .select { |b| b.data.name == 'simple-budget-planner' }
      .map    { |b| b.user.email }
      .each do |email|
      if opts[:confirm] == 'prod'
        BudgetPlanner::DeprecationNotifier.delay(queue: 'frontend_email').bp3(email)
        $stdout.write '.'
      else
        puts email
      end
    end
  end
end
