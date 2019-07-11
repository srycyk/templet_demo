
require 'json'

unless defined? UNPROCESSABLE_ENTITY
  STATUS_SUCCESS, STATUS_CREATED, STATUS_NO_CONTENT = 200, 201, 204

  UNPROCESSABLE_ENTITY = 422
end

shared_examples 'a json controller' do |actions|
  # Naming the model and its belongs_to dependent
  let(:model_name) { new_model.model_name }

  let(:model_singular) { model_name.to_s }

  #let(:model_plural) { model_name.plural }
  let(:model_plural) { model_singular.to_s.pluralize.to_sym }

  let(:model_class) { new_model.class }

  let(:parent_name) { nil }

  let(:parent) { parent_name and new_model.send(parent_name) }

  #let(:foster_parent) { parent_name and create(parent_name) }

  # Rest paths

  #let :foster_parent_path do
  #  foster_parent ? "/#{foster_parent.model_name.plural}/#{foster_parent.id}" : ''
  #end

  let(:scope) { nil }

  let(:controller_name) { model_plural }

  let(:scoped) { scope ? "#{scope}/" : '' }

  let(:parent_elements) { parent ? "/#{parent.model_name.plural}/#{parent.id}" : '' }

  let(:collection_path) { "#{scoped}#{parent_elements}/#{controller_name}" }

  let(:member_path) { "#{collection_path}/#{model.id}" }

  # Model sample field names and values

  let(:field_name) { :name }

  let(:field_value) { 'Previous' }

  let(:new_field_value) { 'Latest' }

  let(:invalid_field_value) { '' }

  let(:invalid_text) { 'blank' }

  let(:field_values) { %w(First Second Third) }

  # Model instances

  let(:new_model) { build model_singular, field_name => field_value }

  let(:model) { create model_singular, field_name => field_value }

  let(:models) do
    field_values.map {|value| create model_singular, field_name => value }
  end

  # Request parameters

  def model_params(**params)
    { model_singular => params }
  end

  let(:format) { { format: :json } }

  # Utilities

  def json(response)
    JSON.parse response.body
  end

  def extract(response, key=nil)
    parsed = json response

    if block_given?
      yield parsed
    else
      parsed[key.to_s]
    end
  end

  def find_model(value=new_field_value)
    model_class.find_by(field_name => value)
  end

  if not actions or actions.include? :index
    describe "GET #index" do
      it "shows models" do
        models

        response = get(collection_path, format)

        expect(response.status).to eq STATUS_SUCCESS

        values = extract(response) do |atts_array|
                   atts_array.map {|atts| atts[field_name.to_s] }
                 end

        expect(values).to eq field_values
      end
    end
  end

  if not actions or actions.include? :show
    describe "GET #show" do
      it "shows model" do
        response = get(member_path, format)

        expect(response.status).to eq STATUS_SUCCESS

        expect(extract response, field_name).to eq field_value
      end
    end
  end

  if not actions or actions.include? :create
    describe "POST #create" do
      it "saves valid model" do
        params = model_params(field_name => new_field_value).merge format

        response = post(collection_path, params)

        expect(response.status).to eq STATUS_CREATED

        expect(extract response, field_name).to eq new_field_value

        expect(find_model[field_name]).to eq new_field_value
      end

      it "handles invalid model" do
        params = model_params(field_name => invalid_field_value).merge format

        response = post(collection_path, params)

        expect(response.status).to eq UNPROCESSABLE_ENTITY

        expect(extract(response, field_name).first).to match /#{invalid_text}/
      end
    end
  end

  if not actions or actions.include? :update
    describe "PUT #update" do
      it "alters valid model" do
        params = model_params(field_name => new_field_value).merge format

        response = put(member_path, params)

        expect(response.status).to eq STATUS_SUCCESS

        expect(extract response, field_name).to eq new_field_value

        expect(find_model[field_name]).to eq new_field_value
      end

      it "handles invalid model" do
        params = model_params(field_name => invalid_field_value).merge format

        response = put(member_path, params)

        expect(response.status).to eq UNPROCESSABLE_ENTITY

        expect(extract(response, field_name).first).to match /#{invalid_text}/
      end
    end
  end

  if not actions or actions.include?(:delete) or actions.include?(:destroy)
    describe "DELETE #destroy" do
      it "deletes model" do
        model

        expect { delete(member_path, format) }
          .to change { model_class.count }
          .by(-1)
      end

      it "returns no_content status" do
        response = delete(member_path, format)

        expect(response.status).to eq STATUS_NO_CONTENT
      end
    end
  end
end
