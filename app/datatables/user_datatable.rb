# UserDatatable Class.
#
# @author julio.antunez.tarin@gmail.com
class UserDatatable < AjaxDatatablesRails::Base
  include AjaxDatatablesRails::Extensions::Kaminari

  def_delegators :@view, :link_to, :user_path, :edit_user_path, :fa_icon,
                 :content_tag, :t

  # Set sortable columns.
  #
  # @return [void]
  def sortable_columns
    @sortable_columns ||= ['users.fullname', 'users.email', 'roles.name']
  end

  # Set searchable columns.
  #
  # @return [void]
  def searchable_columns
    @searchable_columns ||= ['users.fullname', 'users.email', 'roles.name']
  end

  # Set data.
  #
  # :nocov:
  # @return [void]
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
                                     data: {
                                       confirm: t('crud.link.destroy.confirm')
                                     }))
      ]
    end
  end
  private :data
  # :nocov:

  # Get raw records.
  #
  # @return [User::ActiveRecord_Relation] the query result data.
  def get_raw_records
    User.joins(:roles).references(:roles).distinct
  end
  private :get_raw_records

  # ==== Insert 'presenter'-like methods below if necessary
end
