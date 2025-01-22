class PeopleController < ApplicationController

  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_attributes)

    if @person.save
      redirect_to people_path, notice: 'Successfully created entry'
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@person, partial: 'people/form', locals: { person: @person }) }
        format.html { render :new }
      end
    end
  end

  private

  def person_attributes
    params.require(:person).permit(:name, :email, :phone_number)
  end

end

