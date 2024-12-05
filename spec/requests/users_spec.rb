require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) } # Cria um usuário utilizando FactoryBot

  # TESTE DE CRIAÇÃO
  describe "POST /users" do
    let(:valid_attributes) { { username: "new_user", email: "new_user@example.com" } }
    let(:invalid_attributes) { { username: "", email: "invalid_user@example.com" } }

    context "quando os dados são válidos" do
      it "cria um novo usuário" do
        expect {
          post users_path, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
        
        expect(response).to have_http_status(201)
        expect(JSON.parse(response.body)['username']).to eq("new_user")
      end
    end

    context "quando os dados são inválidos" do
      it "não cria um usuário" do
        expect {
          post users_path, params: { user: invalid_attributes }
        }.not_to change(User, :count)

        expect(response).to have_http_status(422)
      end
    end
  end

  # TESTE DE LEITURA (SHOW)
  describe "GET /users/:id" do
    it "retorna os dados do usuário" do
      get user_path(user)

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['username']).to eq(user.username)
    end
  end

  # TESTE DE ATUALIZAÇÃO
  describe "PATCH /users/:id" do
    let(:updated_attributes) { { username: "updated_user", email: "updated_user@example.com" } }

    it "atualiza o usuário" do
      patch user_path(user), params: { user: updated_attributes }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['username']).to eq("updated_user")
    end
  end

  # TESTE DE EXCLUSÃO
  describe "DELETE /users/:id" do
    it "deleta um usuário" do
      expect {
        delete user_path(user)
      }.to change(User, :count).by(-1)

      expect(response).to have_http_status(204)
    end
  end
end
