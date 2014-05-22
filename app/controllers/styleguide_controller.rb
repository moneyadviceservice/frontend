class StyleguideController < ApplicationController
  layout 'styleguide/documentation_1col'

  def layouts
    render layout: 'styleguide/documentation_1col'
  end

  def components_website
    @categories = [
      OpenStruct.new(title: 'Insurance', contents: [
        OpenStruct.new(title: 'Choosing home insurance cover'),
        OpenStruct.new(title: 'Do I need car insurance'),
        OpenStruct.new(title: 'Making a claim')
      ]),
      OpenStruct.new(title: 'Debt', contents: [
        OpenStruct.new(title: 'Avoiding the bailiff'),
        OpenStruct.new(title: 'Does money grow on trees - we investigate')
      ])
    ]
  end

  def pages_home
    @categories_for_directory_en = [
      OpenStruct.new(title: 'Debt and borrowing',
                     description: 'Taking control of debt, getting free debt advice, and how to borrow affordably',
                     path: '#url'),
      OpenStruct.new(title: 'Budgeting and managing money',
                     description: 'Advice on running a bank account, planning your finances, and cutting costs',
                     path: '#url'),
      OpenStruct.new(title: 'Saving and investing',
                     description: 'How to save money, types of savings account, and getting started with investing',
                     path: '#url'),
      OpenStruct.new(title: 'Work, pensions and retirement',
                     description: 'Includes redundancy advice, types of pension and annuity, and automatic enrolment information',
                     path: '#url'),
      OpenStruct.new(title: 'Benefits',
                     description: 'Find out what benefits you’re entitled to and learn about Universal Credit',
                     path: '#url'),
      OpenStruct.new(title: 'Births, deaths and family',
                     description: 'Having a baby, making a will, and dealing with divorce and separation',
                     path: '#url'),
      OpenStruct.new(title: 'Insurance',
                     description: 'Help and advice on protecting your family and getting the right home and car insurance',
                     path: '#url'),
      OpenStruct.new(title: 'Homes and mortgages',
                     description: 'Everything you need to know about buying a home and choosing the right mortgage',
                     path: '#url'),
      OpenStruct.new(title: 'Care and disability',
                     description: 'Choosing the right care services, support for carers and paying for the cost of care',
                     path: '#url'),
      OpenStruct.new(title: 'Cars and travel',
                     description: 'Help with buying and running a car, buying foreign currency, and sending money abroad',
                     path: '#url')
    ]

    @categories_for_directory_cy = [
      OpenStruct.new(title: 'Dyled a benthyca',
                     description: 'Cymryd rheolaeth dros ddyled, cael cyngor am ddim ar ddyledion, a sut i fenthyca’n fforddadwy',
                     path: '#url'),
      OpenStruct.new(title: 'Cyllidebu a rheoli arian',
                     description: 'Cyngor ar redeg cyfrif banc, cynllunio’ch arian, a thorri ar gostau',
                     path: '#url'),
      OpenStruct.new(title: 'Cynilo a budsoddi',
                     description: 'Sut i gynilo arian, mathau o gyfrifon cynilo a rhoi cychwyn arni gyda buddsoddi',
                     path: '#url'),
      OpenStruct.new(title: 'Gwaith, pensiynau ac ymddeol',
                     description: 'Yn cynnwys cyngor ar ddileu swydd, mathau o bensiwn a blwydd-dal, a gwybodaeth ar gofrestru awtomatig',
                     path: '#url'),
      OpenStruct.new(title: 'Budd-daliadau',
                     description: 'Edrychwch pa fudd-daliadau y mae gennych hawl iddynt a dysgu am Gredyd Cynhwysol',
                     path: '#url'),
      OpenStruct.new(title: 'Genedigaethau, marwolaethau a theulu',
                     description: 'Cael babi, gwneud ewyllys, ac ymdrin ag ysgaru a gwahanu',
                     path: '#url'),
      OpenStruct.new(title: 'Yswiriant',
                     description: 'Cymorth a chyngor ynghylch gwarchod eich teulu a chael yr yswiriant cartref a char cywir',
                     path: '#url'),
      OpenStruct.new(title: 'Cartrefi a morgeisi',
                     description: 'Popeth y mae angen i chi ei wybod am brynu cartref a dewis y morgais cywir',
                     path: '#url'),
      OpenStruct.new(title: 'Gofal ac anabledd',
                     description: 'Dewis y gwasanaethau gofal cywir, cymorth i ofalwyr a thalu am gost gofal',
                     path: '#url'),
      OpenStruct.new(title: 'Awaiting title',
                     description: 'Awaiting description',
                     path: '#url')
    ]

    render layout: 'styleguide/page_unconstrained'
  end

  def pages_search_results
    render layout: 'styleguide/page'
  end

  def pages_parent_category_page
    render layout: 'styleguide/page'
  end

  def pages_grandchild_category_page
    render layout: 'styleguide/page'
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
    render layout: 'styleguide/page'
  end

  private

  def sections
    @sections ||= Styleguide.new.sections.each_with_object({}) do |(k, v), h|
      h[k] = StyleguideSectionDecorator.new(v)
    end
  end

  helper_method :sections
end
