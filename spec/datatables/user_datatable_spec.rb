require 'rails_helper'

RSpec.describe UserDatatable do
  context '#sortable_columns' do
    before :each do
      view_context = double('view', params: {})
      @datatable = UserDatatable.new(view_context)
    end

    it 'returns custom columns' do
      expect(@datatable.sortable_columns).to eq(
        ['users.fullname', 'users.slug', 'users.email', 'roles.name'])
    end
  end

  context '#searchable_columns' do
    before :each do
      view_context = double('view', params: {})
      @datatable = UserDatatable.new(view_context)
    end

    it 'returns custom columns' do
      expect(@datatable.searchable_columns).to eq(
        ['users.fullname', 'users.slug', 'users.email', 'roles.name'])
    end
  end

  context '#get_raw_records' do
    before :each do
      view_context = double('view', params: {})
      @datatable = UserDatatable.new(view_context)
    end

    it 'returns custom records' do
      expect(@datatable.send(:get_raw_records)).to eq(
        User.joins(:roles).references(:roles).distinct)
    end
  end
end
