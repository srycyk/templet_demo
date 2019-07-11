
require "nokogiri"

module PartialTestHelpers
  def renderer
    Templet::Renderer.new helper
  end

  def partial_for(klass, *args)
    klass.new(renderer, *args)
  end
  def partial(*args, **options)
    partial_for(described_class, *args, **options)
  end

  def render_partial(*args, &block)
    partial.(*args, &block)
  end

  def parse(html)
    Nokogiri::HTML(html)
  end

  def parse_html(selector, single_return: true,
                           render_args: [],
                           html: render_partial(*render_args))
    method = single_return ? :at_css : :css

    parse(html).send(method, selector)
  end
end

