class PageExists < ActiveModel::Validator
  # TODO refactor this code outside of this module
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
    if page == 'welcome'
      exists = true
    end
    if page == 'info'
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
  # purpose defines what the articles does, or at least where it is
  validates :purpose, presence: true
  # so latest text always found first, when searching by purpose
  default_scope -> { order(created_at: :desc) }

end
