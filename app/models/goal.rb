class Goal < ApplicationRecord
  PRIORITIES = %w[low medium high].freeze

  belongs_to :user

  validates :title, length: {maximum: 80}
  validates :description, length: {maximum: 500}

  validates :title, :description, :due_date, :priority, presence: true
  validate :due_date_within_range

  scope :incomplete, -> { where(completed: false) }
  scope :completed, -> { where(completed: true) }
  scope :sorted, -> { order(due_date: :desc, priority: :desc, title: :asc) }

  private

  def due_date_within_range
    if due_date.nil? || due_date < Time.current || due_date > 2100.years.from_now.to_date
      errors.add(:due_date, "must be between today and the year 2100")
    end
  end
end
