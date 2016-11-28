ActionController::Routing::Routes.draw do |map|
  # Page-mounted App
  map.with_options controller: 'page_mount', action: 'proxy' do |page_mount|
    page_mount.connect 'search/accommodations'

    # These are CMS pages:
    # /accommodation/hotel-motel (for each type)
    # /accommodation/kangaroo-island-accommodation/ (for landing page)
    #
    page_mount.connect ':region_name/:accommodation_id',
                       requirements: {
                         region_name: /[a-z-]*-accommodation/,
                         accommodation_id: /\d+.*/
                       }

    page_mount.connect 'transport/*paths'
    page_mount.connect 'tours/*paths'

    page_mount.connect 'app_cells/*paths'

    page_mount.connect 'cart/*paths'

    page_mount.connect 'secure-payment'
    page_mount.connect 'cart_activations/*paths'
    page_mount.connect 'bookings/manage/*paths'

    page_mount.connect 'parties/*paths'
    page_mount.connect 'reset_password/*paths'
    page_mount.connect 'documents/*paths'

    page_mount.connect 'booking-app-js/*paths'
    page_mount.connect 'media/*paths'
  end
end
