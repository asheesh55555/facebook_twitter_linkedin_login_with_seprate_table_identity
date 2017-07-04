class EndorsesController < ApplicationController
	def create
    @article = Article.find(params[:article_id])
    @comment = @article.endorses.create(endorse_params)
    redirect_to article_path(@article)
  end
 
  private
    def endorse_params
      params.require(:endorse).permit(:title, :body)
    end
end
