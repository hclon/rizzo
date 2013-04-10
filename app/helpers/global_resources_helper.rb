require 'browser_support'
require 'host_support'

module GlobalResourcesHelper
  include BrowserSupport, HostSupport

  def primary_navigation_items
    [
      {style:'home', title:'Home', uri: www_url},
      {style:'destinations', title:'Destinations', uri: www_url("destinations")},
      {style:'themes', title:'Themes', uri: www_url("themes")},
      {style:'forum', title:'Thorn Tree forum', uri: www_url("thorntree")},
      {style:'shop', title:'Shop', uri: shop_url},
      {style:'hotels', title:'Hotels', uri: www_url("hotels")},
      {style:'flights', title:'Flights', uri: www_url("bookings/flights.do")},
      {style:'insurance', title:'Insurance', uri: www_url("bookings/insurance.do")}
    ]
  end
  
  def core_navigation_items
    [
      {title:'Destinations', uri: "http://www.lonelyplanet.com/destinations"},
      {title:'Themes', uri: "http://www.lonelyplanet.com/themes"},
      {title:'Shop', uri: "http://shop.lonelyplanet.com"},
      {title:'Thorn Tree Forum', uri: "http://www.lonelyplanet.com/thorntree"},
      {title:'Bookings',
        submenu: [
            {title:'Hotels', uri:'http://www.lonelyplanet.com/hotels', style:'hotels'},
            {title:'Flights', uri:'http://www.lonelyplanet.com/flights/', style:'flights'},
            {title:'Adventure tours', uri:'http://www.lonelyplanet.com/adventure-tours/', style:'adventure-tours'},
            {title:'Sightseeing tours', uri:'http://www.lonelyplanet.com/sightseeing-tours/', style:'sightseeing-tours'}
        ]
      },
      {title:'Insurance', uri: "http://www.lonelyplanet.com/travel-insurance"}
    ]
  end

  def default_secondary_nav
    [
      {:title=>'Need to know', :url=>'#'},
      {:title=>'In pictures', :url=>'#'},
      {:title=>'Things to do', :url=>'#'},
      {:title=>'Tips', :url=>'#'},
      {:title=>'Discussion', :url=>'#'},
      {:title=>'Guidebooks', :url=>'#'},
      {:title=>'Hotels', :url=>'#'},
      {:title=>'Flights', :url=>'#'}
    ]
  end

  def secondary_nav_bar(args)

    render :partial=>'layouts/core/snippets/secondary_navigation_bar', :locals=>{:section_name=>args[:section_name] || nil, :title=>args[:title], :parent=>args[:parent], :slug=>args[:parent_slug], :collection=>args[:collection] || [], :current=> args[:current] || nil}

  end

  def cart_item_element
    capture_haml do
      haml_tag(:a, 'Cart: 0', class: 'nav__item--cart js-user-cart', href: 'http://shop.lonelyplanet.com/cart/view')
    end
  end

  def membership_item_element
    capture_haml do
      haml_tag(:div, class: 'nav__item--user js-user--nav')
    end
  end

  def show_arrow(style)
    if style=='destinations' ||  style=='destinations current'
      capture_haml do
        haml_tag(:span, class: 'arrow')
      end
    end
  end
  
  def section_title(args)
    capture_haml do
      haml_tag(args[:is_body_title] ? :h1 : :div , class: 'header__title') do
        if(args[:title])
          haml_tag(:span, class: 'header__lead') do
            haml_concat args[:title]
          end  
        end  
        if(args[:section_name])
          haml_concat args[:section_name]
        end
      end  
    end  
  end

  def place_heading(title, parent, slug, section)
    capture_haml do
      haml_tag(:span, class: 'place-title') do
        haml_concat(title)
        unless section.nil?
          haml_tag(:span, class: 'accessibility') do
            haml_concat(" " + section)
          end
        end
        unless parent.nil?
          haml_tag(:a, class: 'place-title__parent', href: "http://www.lonelyplanet.com/#{slug}") do
            haml_concat(", " + parent)
          end
        end
      end
    end
  end
  
  def errbit_notifier
    unless params[:errbit] == 'false'
      # haml_tag(:script, src:"#{asset_path 'errbit_notifier.js'}")
      haml_tag(:script, src:"//rizzo.lonelyplanet.com/assets/errbit_notifier.js")
      haml_tag :script do
        haml_concat "window.Airbrake = (typeof(Airbrake) == 'undefined' && typeof(Hoptoad) != 'undefined') ? Hoptoad : Airbrake;"
        haml_concat "window.Airbrake.setKey('#{Airbrake.configuration.js_api_key}');"
        haml_concat "window.Airbrake.setHost('#{Airbrake.configuration.host.dup}:#{Airbrake.configuration.port}');"
        haml_concat "window.Airbrake.setEnvironment('#{Airbrake.configuration.environment_name}');"
        haml_concat "window.Airbrake.setErrorDefaults({ url: '#{request.url}', component: '#{controller_name}', action: '#{action_name}' });"
      end
    end
  end

  def breadcrumbs_nav(breadcrumb_content)
    render :partial=>'layouts/core/snippets/footer_breadcrumbs', locals: {breadcrumbs: breadcrumb_content || []}
  end
  
  def breadcrumb_for(breadcrumb_content=[])
    capture_haml do
      haml_tag(:div, id: 'breadcrumbWrap', class: 'posChange') do
        haml_tag(:ol, id: 'breadcrumb') do
          breadcrumb_content.each_with_index do |item, index|
            li_class = index == breadcrumb_content.size-1 ? "breadcrumb-item last" : "breadcrumb-item twoCol"
            if item[:slug].blank?
              haml_tag(:li, class: li_class) { haml_tag(:span, class: 'breadcrumb-item-title') { haml_concat item[:place] } }
            else
              haml_tag(:li, class: li_class) { haml_tag(:a, class: 'breadcrumb-item-title', href: "http://www.lonelyplanet.com/#{item[:slug]}") { haml_concat item[:place] } }
            end
          end
        end
      end
    end
  end  
  
end
