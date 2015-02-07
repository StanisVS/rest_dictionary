class String
  def is_number?
    true if Integer(self) rescue false
  end
end

class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  before_action :word_params, only: [:create, :update]

  rescue_from (ActionController::ParameterMissing) do |parameter_missing_exception|
    render :text => "Required parameter missing: #{parameter_missing_exception.param}", :status => :bad_request
  end

  rescue_from ActionController::UnknownHttpMethod do
    render nothing: true , status: 405
  end


  # GET /words
  # GET /words.json
  def index
    @words = Word.all
    respond_to do |format|
      format.html
      format.json
      format.xml { render :xml => @words, location: @word }
      format.text
      format.any { render :text => "Invalid format", :status => :not_acceptable }
    end
  end

  # GET /words/1
  # GET /words/1.json
  def show
    respond_to do |format|
      format.html
      format.json
      format.xml { render :xml => @word }
      format.text
      format.any { render :text => "Invalid format", :status => :not_acceptable }
    end
  end

  # GET /words/new
  def new
    @word = Word.new
    respond_to do |format|
      format.html
      format.any { render :text => "Invalid format", :status => :not_acceptable }
    end
  end

  # GET /words/1/edit
  def edit
    respond_to do |format|
      format.html
      format.any { render :text => "Invalid format", :status => :not_acceptable }
    end
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(word_params)
    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, status: 303, notice: 'Word was successfully created.' }
        format.json { render :show, status: :created, location: @word }
        format.xml { render :xml => @word, status: :created, location: @word }
        format.text { render text: "word #{@word.name} with id=#{@word.id} created", status: :ok }
        format.any { render :text => "Invalid format", :status => :not_acceptable }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @word.errors, status: :unprocessable_entity }
        format.xml { render xml: @word.errors, status: :unprocessable_entity }
        format.text { render text: "#{@word.errors.each { |x, y| x }}", status: :unprocessable_entity }
        format.any { render :text => "Invalid format", :status => :not_acceptable }
      end
    end
  end

  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, status: 303, notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @word }
        format.xml { render :show, status: :ok, location: @word }
        format.text { render text: "word #{@word.name} with id=#{@word.id} updated", status: :ok }
        format.any { render :text => "Invalid format", :status => :not_acceptable }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
        format.xml { render xml: @word.errors, status: :unprocessable_entity }
        format.text { render text: "#{@word.errors.each { |x| x }}", status: :unprocessable_entity }
        format.any { render :text => "Invalid format", :status => :not_acceptable }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, status: 303, notice: 'Word was successfully destroyed.' }
      format.json { head :no_content }
      format.xml { head :no_content }
      format.text { render text: "#{@word.id} deleted", status: :no_content }
      format.any { render :text => "Invalid format", :status => :not_acceptable }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_word
    unless (params[:id]).is_number?
      render :text => "id must be int", :status => :bad_request
    else
      @word = Word.find(params[:id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def word_params
    unless request.content_mime_type == "application/x-www-form-urlencoded" || request.content_mime_type == :json
      render text: "unsuported input format", status: :forbidden
    else
      params.require(:word)
      params[:word].require (:name)
      params[:word].require (:definition)
      params.require(:word).permit(:name, :definition)
    end
  end
end
