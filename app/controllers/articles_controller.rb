class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
   include ApplicationHelper
  # GET /articles
  # GET /articles.json
  def tag
  
Tagging.create(:user_id => params[:userID ],article_id: params[:articleID ])


 redirect_to 'articles/#{:articleID}'
            

 
    
  end
  def index
    @articles = Article.all
 session[:conversations] ||= []
 
    @users = User.all.where.not(id: current_user)
    
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])


  end

  # GET /articles/1
  # GET /articles/1.json
  def show
     session[:conversations] ||= []
 
    @users = User.all.where.not(id: current_user)
    
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])

    @users=User.all
  end

  # GET /articles/new
  def new
   # byebug
  @articles = Article.all.order(created_at:  :desc)
 session[:conversations] ||= []
 
    @users = User.all
    
    @conversations = Conversation.includes(:recipient, :messages)
                                 .find(session[:conversations])

    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  def dummy_def
    format.html { redirect_to new_article_path, notice: 'Article was successfully created.' }
    format.json { render :show, status: :created, location: @article }
    format.html { render :new }
    format.json { render json: @article.errors, status: :unprocessable_entity }
  end

  # POST /articles
  # POST /articles.json
  def create
    
    @article = Article.new(article_params)
    @article.user_id=current_user.id
    

  
    respond_to do |format|
      if @article.save
        byebug
        @art_id= @article.id
       @user_idss = params[:vvv ]
       if @user_idss != nil
         
     
        @user_idss.each do |userid|
         Tagging.create(:user_id => userid,article_id: @art_id) 
  
        end
          end
        #Tagging.create(:user_id => params[:abc ],article_id: @art_id)
                #UserMailer.welcome_email(current_user).deliver_now

        format.html { redirect_to new_article_path, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



    def upvote
             @articles =    Article.all
      @article = Article.find(params[:id])
      @article.liked_by current_user
      Notification.create(recipient_id: @article.user.id, actor_id: current_user.id, article_id: @article.id, notifiable_for: "like")
       respond_to do |format|
    format.js {} #render :file => 'articles/article.js.erb'}
     end
  end
 def downvote
               @articles =    Article.all

      @article = Article.find(params[:id])
      @article.downvote_from current_user


      Notification.create(recipient_id: @article.user.id, actor_id: current_user.id, article_id: @article.id, notifiable_for: "dislike")
       respond_to do |format|
    format.js {                } #render :file => 'articles/article.js.erb'}
     end
  end







  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :img)
    end
end
