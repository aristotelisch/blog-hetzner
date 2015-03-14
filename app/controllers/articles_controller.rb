class ArticlesController < ApplicationController
  before_filter :authenticate, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    current_user
    if signed_in?
      @articles = current_user.articles.all
    else
      @articles = Article.includes(:user).where(draft: 'false')
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    user = current_user
    @article = user.articles.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article,
                      notice: 'Article was successfully created.' }
        format.json { render action: 'show', status: :created, location: @article }
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    #logger.debug "params[:draft_button]= #{params[:draft_button]}"
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to edit_article_path(@article),
                      notice: 'Article was successfully updated.' }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      article = params.require(:article).permit(:title, :body, :featured_image, :user_id)
      if params[:draft_button]
        article[:draft] = true
      else
        article[:draft] = false
      end
      article
    end
end
