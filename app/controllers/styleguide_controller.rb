class StyleguideController < ApplicationController
  layout 'styleguide/documentation'

  def layouts
    render layout: 'styleguide/documentation'
  end

  def components_website
    @resource = Core::HomePage.new('Home')
  end

  def pages_home
    @resource = Core::HomePage.new('Home')

    render layout: 'styleguide/page_unconstrained'
  end

  def pages_tool
    def contact_panels_border_top?
      true
    end

    render layout: 'styleguide/page_unconstrained'
  end

  def pages_parent_category_page
    render layout: 'styleguide/page'
  end

  def pages_campaign
    render layout: 'styleguide/page_unconstrained'
  end

  def pages_child_category_page
    render layout: 'styleguide/page'
  end

  def pages_guide
    render layout: 'styleguide/page'
  end

  def pages_action_plan
    render layout: 'styleguide/page'
  end

  def pages_error
    render layout: 'styleguide/page_unconstrained'
  end

  def pages_news_index
    render layout: 'styleguide/page'
  end

  def pages_news_article
    render layout: 'styleguide/page'
  end

  def pages_contact
    render layout: 'styleguide/page'
  end

  def pages_feedback_technical
    render layout: 'styleguide/page'
  end

  def pages_annuities_landing_page
    render layout: 'styleguide/page_unconstrained'
  end

  private

  def article
    { categories: [] }.to_ostruct
  end

  helper_method :article

  def categories
    [
      {
        title:    'Home',
        object:   { contents: [] },
        contents: []
      },
      {
        title:    'Insurance',
        object:   { contents: [] },
        contents: [
          { title: 'Choosing home insurance cover' },
          { title: 'Do I need car insurance' },
          { title: 'Making a claim' }
        ]
      },
      {
        title:    'Debt',
        object:   { contents: [] },
        contents: [
          { title: 'Avoiding the bailiff' },
          { title: 'Does money grow on trees - we investigate' }
        ]
      }
    ].map(&:to_ostruct)
  end

  helper_method :categories

  def categories_related_links
    [
      {
        contents: [
          { title: 'Budgeting tips when you’re on a low income' },
          { title: 'How much can you afford to borrow for a mortgage?' },
          { title: 'Beginner’s guide to managing your money' }
        ]
      }
    ].map(&:to_ostruct)
  end

  helper_method :categories_related_links

  def news
    [{
      title: 'Women are feeling the financial squeeze more than men',
      date: '10 Jun 2014',
      description:
        'Four in ten women feel financially worse off than they did a year ago.'
    }].map(&:to_ostruct)
  end

  helper_method :news

  def sections
    @sections ||= Styleguide.new.sections.each_with_object({}) do |(k, v), h|
      h[k] = StyleguideSectionDecorator.new(v)
    end
  end

  helper_method :sections

  def contact_panels_border_top?
    false
  end

  helper_method :contact_panels_border_top?
end
