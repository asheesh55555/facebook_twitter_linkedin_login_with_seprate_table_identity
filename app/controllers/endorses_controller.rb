class EndorsesController < ApplicationController
	def create
    #byebug
    @article = Article.find(params[:article_id])
    @endorse = @article.endorses.new(endorse_params)
    @endorse.user_id = current_user.id
    @endorse.save
    redirect_to article_path(@article)
  end
 
  private
    def endorse_params
      params.require(:endorse).permit(:title, :body)
    end
end
