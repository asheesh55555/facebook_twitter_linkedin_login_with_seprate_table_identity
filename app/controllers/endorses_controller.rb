class EndorsesController < ApplicationController

	def create
  
    @article = Article.find(params[:article_id])
    @endorse = @article.endorses.new(endorse_params)
    @endorse.user_id = current_user.id
    @endorse.save
    @articles = Article.all
    # redirect_to new_article_path

    # respond_to do |format|
    
    #     format.html { redirect_to new_article_path, notice: 'Article was successfully updated.' }
    #     format.js { }
      
    # end
  end
 
  private
    def endorse_params
      params.require(:endorse).permit(:title, :body)
    end
end
