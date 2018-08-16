require "application_system_test_case"

class Contact::PhonesTest < ApplicationSystemTestCase
  setup do
    @contact_phone = contact_phones(:one)
  end

  test "visiting the index" do
    visit contact_phones_url
    assert_selector "h1", text: "Contact/Phones"
  end

  test "creating a Phone" do
    visit contact_phones_url
    click_on "New Contact/Phone"

    fill_in "Contact", with: @contact_phone.contact_id
    fill_in "Name", with: @contact_phone.name
    fill_in "Phone", with: @contact_phone.phone
    click_on "Create Phone"

    assert_text "Phone was successfully created"
    click_on "Back"
  end

  test "updating a Phone" do
    visit contact_phones_url
    click_on "Edit", match: :first

    fill_in "Contact", with: @contact_phone.contact_id
    fill_in "Name", with: @contact_phone.name
    fill_in "Phone", with: @contact_phone.phone
    click_on "Update Phone"

    assert_text "Phone was successfully updated"
    click_on "Back"
  end

  test "destroying a Phone" do
    visit contact_phones_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Phone was successfully destroyed"
  end
end
