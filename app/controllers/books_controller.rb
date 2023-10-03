class BooksController < ApplicationController
  before_action :authenticate_user!
 before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    @user = @book.user
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
      flash[:notice] = "Book create successfully."
    else
      @books = Book.all
      flash[:notice] = "Book not create successfully."
      render "index"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "Book was successfully destroyed."
  end



  def book_params
    params.require(:book).permit(:title, :body)
  end

 private

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end