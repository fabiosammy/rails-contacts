class Contact::PhonesController < ApplicationController
  before_action :set_contact
  before_action :set_contact_phone, only: [:show, :edit, :update, :destroy]

  # GET /contact/phones
  # GET /contact/phones.json
  def index
    @contact_phones = @contact.phones.all
  end

  # GET /contact/phones/1
  # GET /contact/phones/1.json
  def show
  end

  # GET /contact/phones/new
  def new
    @contact_phone = @contact.phones.new
  end

  # GET /contact/phones/1/edit
  def edit
  end

  # POST /contact/phones
  # POST /contact/phones.json
  def create
    @contact_phone = @contact.phones.new(contact_phone_params)

    respond_to do |format|
      if @contact_phone.save
        format.html { redirect_to contact_phone_path(@contact, @contact_phone), notice: 'Phone was successfully created.' }
        format.json { render :show, status: :created, location: contact_phone_path(@contact, @contact_phone) }
      else
        format.html { render :new }
        format.json { render json: @contact_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contact/phones/1
  # PATCH/PUT /contact/phones/1.json
  def update
    respond_to do |format|
      if @contact_phone.update(contact_phone_params)
        format.html { redirect_to contact_phone_path(@contact, @contact_phone), notice: 'Phone was successfully updated.' }
        format.json { render :show, status: :ok, location: contact_phone_path(@contact, @contact_phone) }
      else
        format.html { render :edit }
        format.json { render json: @contact_phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact/phones/1
  # DELETE /contact/phones/1.json
  def destroy
    @contact_phone.destroy
    respond_to do |format|
      format.html { redirect_to contact_phones_url(@contact), notice: 'Phone was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_contact
    @contact = Contact.find(params[:contact_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_contact_phone
    @contact_phone = @contact.phones.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_phone_params
    params.require(:contact_phone).permit(:name, :phone)
  end
end
