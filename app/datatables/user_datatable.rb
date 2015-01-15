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
    @sortable_columns ||= ['users.fullname', 'users.slug', 'users.email',
                           'roles.name']
  end

  # Set searchable columns.
  #
  # @return [void]
  def searchable_columns
    @searchable_columns ||= ['users.fullname', 'users.slug', 'users.email',
                             'roles.name']
  end

  # Set data.
  #
  # @return [void]
  def data
    records.includes(:roles).map do |record|
      [
        record.fullname,
        record.slug,
        record.email,
        record.roles.distinct.join(', '),
        build_record_actions(record)
      ]
    end
  end
  private :data

  # Build record actions
  #
  # @param [User] record the user record
  # @return [String] the action links
  def build_record_actions(record)
    show_link   = link_to(fa_icon('ellipsis-h'), user_path(record))
    show        = content_tag(:span, show_link)

    edit_link   = link_to(fa_icon('edit'), edit_user_path(record))
    edit        = content_tag(:span, edit_link)

    delete_link = link_to(
      fa_icon('remove'),
      user_path(record),
      method: :delete,
      data: {
        confirm: t('crud.link.destroy.confirm')
      }
    )
    delete      = content_tag(:span, delete_link)

    "#{show}#{edit}#{delete}"
  end
  private :build_record_actions

  # Get raw records.
  #
  # @return [User::ActiveRecord_Relation] the query result data.
  def get_raw_records
    User.joins(:roles).references(:roles).distinct
  end
  private :get_raw_records

  # ==== Insert 'presenter'-like methods below if necessary
end
