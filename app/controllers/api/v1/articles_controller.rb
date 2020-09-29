module Api
  module V1
    class ArticlesController < ApplicationController
      def index
        articles = Article.order('created_at DESC')
        render json: {
          status: 'Success',
          message: 'Loaded Articles',
          data: articles
        }, status: :ok
      end

      def show
        article = Article.find(params[:id])
        render json: {
          status: 'Success',
          message: 'Loaded article',
          data: article
        }, status: :ok
      end

      def create
        article = Article.new(article_params)

        if article.save
          render json: {
            status: 'Success',
            message: 'Saved article',
            data: article
          }, status: :ok
        else
          render json: {
            status: 'Error',
            message: 'Article not saved',
            data: article.errors
          }, status: :unprocessable_entity
        end
      end

      def update
        article = Article.find(params[:id])

        if article.update(article_params)
          render json: {
            status: 'Success',
            message: 'Article updated',
            data: article
          }, status: :ok
        else
          render json: {
            status: 'Error',
            message: 'Article not updated',
            data: article
          }, status: :unprocessable_entity
        end
      end

      def destroy
        article = Article.find(params[:id])
        article.destroy
        render json: {
          status: 'Success',
          message: 'Deleted article',
          data: article
        }, status: :ok
      end

      private
      def article_params
        params.permit(:title, :body)
      end
    end
  end
end