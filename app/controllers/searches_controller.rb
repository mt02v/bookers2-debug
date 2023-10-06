class SearchesController < ApplicationController

  def search
   @model = params[:model]
   @word = params[:word]
   @search =params[:search]

  if @model == "user"
    @records == User.looks(@search, @word)
  else
    @records = Book.look(@search, @word)
  end
  end

end
