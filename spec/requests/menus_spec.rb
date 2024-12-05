# spec/requests/menus_spec.rb
require 'rails_helper'

RSpec.describe "Menus", type: :request do
  let(:user) { create(:user) }
  let(:restaurant) { create(:restaurant, user: user) }
  let!(:menu) { create(:menu, restaurant: restaurant, user: user) } # Menu existente para testes
  let(:valid_attributes) do
    { name: "New Dish", description: "Delicious meal", price: 29.99, restaurant_id: restaurant.id, user_id: user.id }
  end
  let(:invalid_attributes) do
    { name: nil, description: "No name dish", price: 29.99, restaurant_id: restaurant.id, user_id: user.id }
  end

  # INDEX: Lista todos os menus
  describe "GET /menus" do
    it "retorna uma lista de menus" do
      get menus_path

      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json).to be_an(Array)
      expect(json.first["name"]).to eq(menu.name)
    end
  end

  # SHOW: Exibe um menu específico
  describe "GET /menus/:id" do
    it "retorna o menu solicitado" do
      get menu_path(menu)

      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["name"]).to eq(menu.name)
      expect(json["description"]).to eq(menu.description)
    end

    it "retorna erro 404 para um ID inexistente" do
      get menu_path(id: 99999)

      expect(response).to have_http_status(404)
    end
  end

  # CREATE: Cria um novo menu
  describe "POST /menus" do
    context "com atributos válidos" do
      it "cria um novo menu" do
        expect {
          post menus_path, params: { menu: valid_attributes }
        }.to change(Menu, :count).by(1)

        expect(response).to have_http_status(201)
        json = JSON.parse(response.body)
        expect(json["name"]).to eq("New Dish")
      end
    end

    context "com atributos inválidos" do
      it "não cria o menu e retorna erro 422" do
        expect {
          post menus_path, params: { menu: invalid_attributes }
        }.not_to change(Menu, :count)

        expect(response).to have_http_status(422)
      end
    end
  end

  # UPDATE: Atualiza um menu existente
  describe "PATCH /menus/:id" do
    let(:updated_attributes) { { name: "Updated Dish", price: 39.99 } }

    context "com atributos válidos" do
      it "atualiza o menu" do
        patch menu_path(menu), params: { menu: updated_attributes }

        expect(response).to have_http_status(200)
        json = JSON.parse(response.body)
        expect(json["name"]).to eq("Updated Dish")
        expect(json["price"]).to eq("39.99") # Decimal é representado como string no JSON
      end
    end

    context "com atributos inválidos" do
      it "não atualiza o menu e retorna erro 422" do
        patch menu_path(menu), params: { menu: { name: nil } }

        expect(response).to have_http_status(422)
      end
    end
  end

  # DELETE: Remove um menu
  describe "DELETE /menus/:id" do
    it "remove o menu e retorna status 204" do
      expect {
        delete menu_path(menu)
      }.to change(Menu, :count).by(-1)

      expect(response).to have_http_status(204)
    end

    it "retorna erro 404 para um ID inexistente" do
      delete menu_path(id: 99999)

      expect(response).to have_http_status(404)
    end
  end
end
