class Order < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :order_items

  accepts_nested_attributes_for :order_items

  STATUS_CONST = {
    processing: 0,
    complete: 1,
    edited: 2,
    declined: 3
  }

  enum status: STATUS_CONST
end
