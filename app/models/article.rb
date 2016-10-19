# TODO refactor this code outside of this module
# validate that the page name exists
class PageExists < ActiveModel::Validator
  def validate record
    unless valid_page(record.page)
      record.errors.add(:page, "name is incorrect.")
    end
  end

  # TODO refactor this to match the ruby idomatic way
  def valid_page page
    # ignore case
    if page
      page.downcase!
    else
      return false
    end
    # verify page name
    exists = false
    if page == 'about'
      exists = true
    end
    if page == 'contact'
      exists = true
    end
    return exists
  end
end

class Article < ApplicationRecord
  include ActiveModel::Validations
  # perform custom validation for page attribute
  validates_with PageExists
  # attributes: title:string, body:text, page:string
  validates :body, presence: true
  # consider having some order or position

end
