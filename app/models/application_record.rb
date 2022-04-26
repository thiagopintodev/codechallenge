class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  PER_PAGE = 3

  def self.paginated(page = nil)
    page = page.to_i
    page = 1 if page < 1

    per_page = PER_PAGE
    offset = (page - 1) * per_page
    records = limit(per_page).offset(offset).reverse_order

    max_pages = (count.to_f / per_page).ceil
    pages = 1..max_pages

    [page, pages, records]
  end

  def self.before(before = nil)
    before = before.to_i
    before = 0 if before < 0

    per_page = PER_PAGE
    records = limit(per_page).reverse_order

    records = records.where('id < ?', before) if before.positive?

    before = records[per_page-1]

    [before, records]
  end
end
