class ExpressionsController < ApplicationController

  require 'open-uri'

  active_scaffold :expression do |conf|
    conf.columns = [:image, :name, :definition, :collection]
    # open links in new pages and as popups
    conf.create.link.page = true
    conf.create.link.popup = true
    conf.create.link.label = "Create new expression "

    conf.update.link.page = true
    conf.update.link.popup = true

    #conf.delete.link.inline = false
  end

  # active scaffold action
  # GET /expressions
  # GET /expressions.json
  #def index
  #  @expressions = Expression.all
  #
  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @expressions }
  #    #format.js{
  #    #  collection = Collection.find(params[:assoc_id])
  #    #  @expressions = collection.expressions
  #    #}
  #  end
  #end

  # GET /expressions/1
  # GET /expressions/1.json
  def show
    @expression = Expression.find(params[:id])


  end

  # GET /expressions/new
  # GET /expressions/new.json
  def new
    @expression = Expression.new
    # set collection id from active scaffold params
    if !params[:eid].nil?
      @collection_id = params[:eid].gsub("collections_","").gsub("_expressions","").to_i
      collection = Collection.find_by_id(@collection_id)
      @expression.collection = collection
    end


  end

  # GET /expressions/1/edit
  def edit
    @expression = Expression.find(params[:id])
  end

  # POST /expressions
  # POST /expressions.json
  def create
    @expression = Expression.new(params[:expression])
    set_image_from_params

    respond_to do |format|
      if @expression.save
        format.html { redirect_to @expression, :notice => 'Expression was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /expressions/1
  # PUT /expressions/1.json
  def update
    @expression = Expression.find(params[:id])
    set_image_from_params

    respond_to do |format|
      if @expression.update_attributes(params[:expression])
        format.html { redirect_to @expression, :notice => 'Expression was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # active scaffold action
  # DELETE /expressions/1
  # DELETE /expressions/1.json
  #def destroy
  #  @expression = Expression.find(params[:id])
  #  @expression.destroy
  #
  #  respond_to do |format|
  #    format.html { redirect_to expressions_url }
  #    format.json { head :ok }
  #  end
  #end


  # POST /expressions/load_data
  # loads data for expression from external sources
  def load_data
    @query = params[:expression][:name].strip
    #@images = GoogleImage.search(query)

    @definitions = Wordnik.word.get_definitions(@query, :useCanonical => 'true').map { |d| d["text"] }

    examples = Wordnik.word.get_examples(@query, :useCanonical => 'true')["examples"]
    if examples.nil?
      @examples = []
    else
      @examples = examples.map { |e| e["text"] }
    end

    synonym_response = Wordnik.word.get_related_words(@query, :type => 'synonym', :useCanonical => 'true')
    if synonym_response.empty?
      @synonyms = []
    else
      @synonyms = synonym_response.first["words"]
    end

    @audios = Wordnik.word.get_audio(@query).select { |a| a["audioType"]=="pronunciation" }.map { |a| a["fileUrl"] }
  end


  private

  # saves paperclip image from external source
  def set_image_from_params
    @expression.image = open(params[:image_url]) unless params[:image_url].empty?
  rescue #OpenURI::HTTPError => error
         #open error
  end

end
