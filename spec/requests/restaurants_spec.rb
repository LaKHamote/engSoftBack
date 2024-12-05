# spec/requests/restaurants_spec.rb
require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  let(:user) { create(:user) } # Usuário associado ao restaurante
  let!(:restaurant) { create(:restaurant, user: user) } # Restaurante existente para os testes
  let(:valid_attributes) { { name: "New Restaurant", location: "New City", description: "A great place", user_id: user.id } }
  let(:invalid_attributes) { { name: nil, location: "No Name City", user_id: user.id } }

  # INDEX: Lista todos os restaurantes
  describe "GET /restaurants" do
    it "retorna uma lista de restaurantes" do
      get restaurants_path

      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json).to be_an(Array)
      expect(json.first["name"]).to eq(restaurant.name)
    end
  end

  # SHOW: Exibe um restaurante específico
  describe "GET /restaurants/:id" do
    it "retorna o restaurante solicitado" do
      get restaurant_path(restaurant)

      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["name"]).to eq(restaurant.name)
      expect(json["location"]).to eq(restaurant.location)
    end

    it "retorna erro 404 para um ID inexistente" do
      get restaurant_path(id: 99999)

      expect(response).to have_http_status(404)
    end
  end

  # CREATE: Cria um novo restaurante
  describe "POST /restaurants" do
    context "com atributos válidos" do
      it "cria um novo restaurante" do
        expect {
          post restaurants_path, params: { restaurant: valid_attributes }
        }.to change(Restaurant, :count).by(1)

        expect(response).to have_http_status(201)
        json = JSON.parse(response.body)
        expect(json["name"]).to eq("New Restaurant")
      end
    end

    context "com atributos inválidos" do
      it "não cria o restaurante e retorna erro 422" do
        expect {
          post restaurants_path, params: { restaurant: invalid_attributes }
        }.not_to change(Restaurant, :count)

        expect(response).to have_http_status(422)
      end
    end
  end

  # UPDATE: Atualiza um restaurante existente
  describe "PATCH /restaurants/:id" do
    let(:updated_attributes) { { name: "Updated Restaurant", location: "Updated City" } }

    context "com atributos válidos" do
      it "atualiza o restaurante" do
        patch restaurant_path(restaurant), params: { restaurant: updated_attributes }

        expect(response).to have_http_status(200)
        json = JSON.parse(response.body)
        expect(json["name"]).to eq("Updated Restaurant")
        expect(json["location"]).to eq("Updated City")
      end
    end

    context "com atributos inválidos" do
      it "não atualiza o restaurante e retorna erro 422" do
        patch restaurant_path(restaurant), params: { restaurant: { name: nil } }

        expect(response).to have_http_status(422)
      end
    end
  end

  # DELETE: Remove um restaurante
  describe "DELETE /restaurants/:id" do
    it "remove o restaurante e retorna status 204" do
      expect {
        delete restaurant_path(restaurant)
      }.to change(Restaurant, :count).by(-1)

      expect(response).to have_http_status(204)
    end

    it "retorna erro 404 para um ID inexistente" do
      delete restaurant_path(id: 99999)

      expect(response).to have_http_status(404)
    end
  end
end
