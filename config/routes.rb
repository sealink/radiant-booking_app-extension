ActionController::Routing::Routes.draw do |map|
  # Page-mounted App
  map.with_options controller: 'page_mount', action: 'proxy' do |page_mount|
    page_mount.connect 'search/accommodations', layout: 'content-wide'

    # These are CMS pages:
    # /accommodation/hotel-motel (for each type)
    # /accommodation/kangaroo-island-accommodation/ (for landing page)
    #
    page_mount.connect ':region_name/:accommodation_id',
                       requirements: {
                         region_name: /[a-z-]*-accommodation/,
                         accommodation_id: /\d+.*/
                       }

    page_mount.connect 'transport/*paths', layout: 'content-simple'
    page_mount.connect 'tours/*paths', layout: 'content-simple'

    page_mount.connect 'cells/*paths', layout: 'blank'

    page_mount.connect 'cart/*paths', layout: '%{domain_key}-cart'

    page_mount.connect 'secure-pay', layout: '%{domain_key}-cart'
    page_mount.connect 'cart_activations/*paths', layout: '%{domain_key}-cart'
    page_mount.connect 'bookings/manage/*paths', layout: '%{domain_key}-cart'

    page_mount.connect 'parties/*paths', layout: 'blank'
    page_mount.connect 'documents/*paths', layout: 'blank'

    page_mount.connect 'booking-app-js/*paths', layout: 'blank'
    page_mount.connect 'media/*paths', layout: 'blank'
  end
end
