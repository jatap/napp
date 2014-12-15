class UserDatatable < AjaxDatatablesRails::Base

  include AjaxDatatablesRails::Extensions::Kaminari

  def_delegators :@view, :link_to, :user_path, :edit_user_path, :fa_icon,
                 :content_tag

  def sortable_columns
    @sortable_columns ||= [ 'users.fullname', 'users.email', 'roles.name' ]
  end

  def searchable_columns
    @searchable_columns ||= [ 'users.fullname', 'users.email', 'roles.name' ]
  end

  private

  def data
    records.map do |record|
      [
          record.fullname,
          record.email,
          record.roles.join(', '),
          content_tag(:span, link_to(fa_icon('ellipsis-h'), user_path(record))) +
          content_tag(:span, link_to(fa_icon('edit'), edit_user_path(record))) +
          content_tag(:span, link_to(fa_icon('remove'), user_path(record),
                                     method: :delete,
                                     data: { confirm: 'Are you sure?' }))
      ]
    end
  end

  def get_raw_records
    User.joins(:roles).references(:roles).distinct
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
