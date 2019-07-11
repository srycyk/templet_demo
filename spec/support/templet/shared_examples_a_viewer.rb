
#require_relative "partial_test_helpers"

  shared_examples 'a viewer' do |actions|
    include PartialTestHelpers

    let(:scope) { nil }

    let(:controller_name) { nil }

    let(:model) { create model_name, field_name => field_value }

    let(:parent) { model.send parent_name if model.respond_to?(parent_name || '') }

    let(:new_model) { build model_name, field_name => field_value }

    let(:field_values) { %w(First Second Third) }

    let :models do
      field_values.map {|value| create model_name, field_name => value }
    end

    let(:parent_name) { }

    let(:grand_parent_name) { }

    let(:field_name) { :name }

    let(:field_value) { "#{model_name} #{field_name}" }

    let(:input_field_tag) { "input" }

    let(:index_selector) { 'tbody tr td:first' }

    let(:field_selector) { "#{input_field_tag}[id=#{model_name}_#{field_name}]" }

    let(:list_selector) { 'dl dd:first' }

    def viewer(model, parent=nil, **opts)
      if scope or controller_name
        opts[:controller] = (scope ? "#{scope}/" : '') +
                            (controller_name&.to_s || model_name.to_s.pluralize)
      end

      opts[:grand_parent] = grand_parent_name if grand_parent_name

      described_class.new helper, model, parent, **opts
    end

    if not actions or actions.include? :index
      describe '#index' do
        it "shows model queries" do
          html = viewer(model_name, parent, models: models).index

          queries = parse_html(index_selector, html: html, single_return: false)

          expect(queries.map(&:text)).to eq field_values
        end
      end
    end

    if not actions or actions.include? :show
      describe '#show' do
        it 'displays field value' do
          html = viewer(model, parent).show

          value = parse_html(list_selector, html: html).text

          expect(value).to eq field_value
        end
      end
    end

    if not actions or actions.include? :new
      describe '#new' do
        it 'prompts for field value' do
          helper.instance_variable_set("@#{model_name}", new_model)

          html = viewer(new_model, parent).new

          selected = parse_html(field_selector, html: html)

          value = selected['value'] || selected.text

          expect(value.strip).to eq field_value
       end
      end
    end

    if not actions or actions.include? :edit
      describe '#edit' do
        it 'prompts for field value' do
          helper.instance_variable_set("@#{model_name}", model)

          html = viewer(model, parent).edit

          selected = parse_html(field_selector, html: html)

          value = selected['value'] || selected.text

          expect(value.strip).to eq field_value
        end
      end
    end
  end
