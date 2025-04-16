RSpec.describe ActiveAdmin::SortableTable, 'Drag-and-Drop', type: :feature, js: true do
  before do
    Category.create!
    Category.create!
    Category.create!
  end

  def ordered_ids
    Category.order(:number).pluck(:id)
  end

  context 'first page' do
    before do
      expect(ordered_ids).to eq([1, 2, 3])

      visit admin_categories_path

      expect(visible_ids).to eq([1, 2, 3])
      expect(visible_numbers).to eq([1, 2, 3])
    end

    context 'move element up' do
      it 'to the top number' do
        move_up(3, by: 2)

        expect(visible_ids).to eq([3, 1, 2])
        expect(visible_numbers).to eq([1, 2, 3])
        expect(ordered_ids).to eq([3, 1, 2])
      end

      it 'to the middle of the table' do
        move_up(3, by: 1)

        expect(visible_ids).to eq([1, 3, 2])
        expect(visible_numbers).to eq([1, 2, 3])
        expect(ordered_ids).to eq([1, 3, 2])
      end
    end

    context 'move element down' do
      it 'to the bottom of the table' do
        move_down(1, by: 2)

        expect(visible_ids).to eq([2, 3, 1])
        expect(visible_numbers).to eq([1, 2, 3])
        expect(ordered_ids).to eq([2, 3, 1])
      end

      it 'to the middle of the table' do
        move_down(2, by: 1)

        expect(visible_ids).to eq([1, 3, 2])
        expect(visible_numbers).to eq([1, 2, 3])
        expect(ordered_ids).to eq([1, 3, 2])
      end
    end

    it 'can not drag not by handle' do
      move_up(3, by: 2, use_handle: false)

      expect(visible_ids).to eq([1, 2, 3])
      expect(visible_numbers).to eq([1, 2, 3])
      expect(ordered_ids).to eq([1, 2, 3])
    end
  end

  context 'second page' do
    before do
      Category.create!
      Category.create!
      Category.create!
    end

    before do
      expect(ordered_ids).to eq([1, 2, 3, 4, 5, 6])

      visit admin_categories_path(page: 2)

      expect(visible_ids).to eq([4, 5, 6])
      expect(visible_numbers).to eq([4, 5, 6])
    end

    context 'move element up' do
      it 'to the top position' do
        move_up(6, by: 2)

        expect(visible_ids).to eq([6, 4, 5])
        expect(visible_numbers).to eq([4, 5, 6])
        expect(ordered_ids).to eq([1, 2, 3, 6, 4, 5])
      end

      it 'to the middle of the table' do
        move_up(6, by: 1)

        expect(visible_ids).to eq([4, 6, 5])
        expect(visible_numbers).to eq([4, 5, 6])
        expect(ordered_ids).to eq([1, 2, 3, 4, 6, 5])
      end
    end

    context 'move element down' do
      it 'to the bottom of the table' do
        move_down(4, by: 2)

        expect(visible_ids).to eq([5, 6, 4])
        expect(visible_numbers).to eq([4, 5, 6])
        expect(ordered_ids).to eq([1, 2, 3, 5, 6, 4])
      end

      it 'to the middle of the table' do
        move_down(4, by: 1)

        expect(visible_ids).to eq([5, 4, 6])
        expect(visible_numbers).to eq([4, 5, 6])
        expect(ordered_ids).to eq([1, 2, 3, 5, 4, 6])
      end
    end

    it 'can not drag not by handle' do
      move_down(6, by: 2, use_handle: false)

      expect(visible_ids).to eq([4, 5, 6])
      expect(visible_numbers).to eq([4, 5, 6])
      expect(ordered_ids).to eq([1, 2, 3, 4, 5, 6])
    end
  end

  private

  def visible_ids
    all('.ui-sortable .col-id').map(&:text).map(&:to_i)
  end

  def visible_numbers
    all('.ui-sortable .col-number').map(&:text).map(&:to_i)
  end

  def move_up(element_id, by: 1, use_handle: true)
    drag_element(element_id, by: -by, use_handle: use_handle)
  end

  def move_down(element_id, by: 1, use_handle: true)
    drag_element(element_id, by: by, use_handle: use_handle)
  end

  def drag_element(element_id, by:, use_handle:)
    if use_handle
      page.execute_script(<<-JS)
        $("#category_#{element_id}").simulateDragSortable({ move: #{by}, handle: ".handle" })
      JS
    else
      page.execute_script(<<-JS)
        $("#category_#{element_id}").simulateDragSortable({ move: #{by} })
      JS
    end
    sleep 0.7
  end
end
