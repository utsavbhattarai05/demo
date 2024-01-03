
require 'rails_helper'

RSpec.describe PostsController do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end


  describe 'GET #show' do
    it 'returns a success response' do
      post = Post.create(title: 'Test Title', content: 'Test Content')
      get :show, params: { id: post.id }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      post = Post.create(title: 'Test Title', content: 'Test Content')
      get :edit, params: { id: post.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Post' do
        post_params = { post: { title: 'Test Title', content: 'Test Content' } }
        expect {
          post :create, params: post_params
        }.to change(Post, :count).by(1)
      end

      it 'redirects to the created post' do
        post_params = { post: { title: 'Test Title', content: 'Test Content' } }
        post :create, params: post_params
        expect(response).to redirect_to(post_url(Post.last))
      end
    end

    context 'with invalid parameters' do
      it 'returns an unprocessable entity status' do
        post_params = { post: { title: nil, content: 'Test Content' } }
        post :create, params: post_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the requested post' do
        post = Post.create(title: 'Test Title', content: 'Test Content')
        new_attributes = { title: 'Updated Title' }
        patch :update, params: { id: post.id, post: new_attributes }
        post.reload
        expect(post.title).to eq('Updated Title')
      end

      it 'redirects to the post' do
        post = Post.create(title: 'Test Title', content: 'Test Content')
        new_attributes = { title: 'Updated Title' }
        patch :update, params: { id: post.id, post: new_attributes }
        expect(response).to redirect_to(post_url(post))
      end
    end

    context 'with invalid parameters' do
      it 'returns a success status (:unprocessable_entity)' do
        post = Post.create(title: 'Test Title', content: 'Test Content')
        invalid_attributes = { title: nil }
        patch :update, params: { id: post.id, post: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  
    


  describe 'DELETE #destroy' do
    it 'destroys the requested post' do
      post = Post.create(title: 'Test Title', content: 'Test Content')
      expect {
        delete :destroy, params: { id: post.id }
      }.to change(Post, :count).by(-1)
    end

    it 'redirects to the posts list' do
    post = Post.create(title: 'Test Title', content: 'Test Content')
    delete :destroy, params: { id: post.id }
    expect(response).to redirect_to(posts_url)
  end
  end
end
