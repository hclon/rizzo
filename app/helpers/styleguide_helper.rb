module StyleguideHelper

  def left_nav
    {
      groups: [
        {
          title: "Components",
          items: [
            {
              name: "Cards",
              path: "/styleguide",
              extra_style: "nav__item--delimited"
            },
            {
              name: "Navigation",
              path: "/styleguide/navigation",
              extra_style: "nav__item--delimited"
            },
            {
              name: "Forms",
              path: "/styleguide/forms",
              extra_style: "nav__item--delimited"
            }
          ]
        },
        {
          title: "Colours",
          items: [
            {
              name: "Design palette",
              path: "/styleguide/colours",
              extra_style: "nav__item--delimited"
            },
            {
              name: "UI Colours",
              path: "/styleguide/ui-colours",
              extra_style: "nav__item--delimited"
            }
          ]
        }
      ]
    }
  end

  def ad_config
    {hints: "", channels: ""}
  end

  def ui_component(path, opts={})
    render :partial => "components/#{path}", :locals => opts
  end

  def sg_component(path, opts)
    count = opts.delete(:count)
    item_class = count ? "styleguide-block__item styleguide-block__item--#{count}" : "styleguide-block__item"
    capture_haml do
      haml_tag(:div, class: "styleguide-block") do
        haml_tag(:div, class: item_class) do
          haml_concat ui_component(path, opts)
        end
        haml_concat render "styleguide/partials/description", component: path, opts: opts[:original_stub] ? {stack_item: opts[:original_stub]} : opts
      end
    end
  end

  def get_colours(file)
    colours = File.read(File.expand_path("../../assets/stylesheets/_variables/#{file}.sass", __FILE__))
    colours = colours.split("// -----------------------------------------------------------------------------\n")
    colours.delete_if(&:empty?)
    groups = []
    counter = -1
    colours.each do |section|
      if section[0..1] == "//"
        groups.push({title: section})
        counter = counter + 1
      else
        groups[counter][:body] = section
      end
    end
    groups
  end

  def get_luminance(hex)
    hex = "#{hex}#{hex.match(/[0-9A-Fa-f]{3}/)[0]}" if hex.length < 7
    rgb = hex.scan(/[0-9A-Fa-f]{2}/).collect { |i| i.to_i(16) }
    (0.2126*rgb[0]) + (0.7152*rgb[1]) + (0.0722*rgb[2])
  end

end