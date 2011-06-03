require 'test_helper'

class RQRCode::SVGTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, RQRCode
  end

  test 'returns an HTML-safe string' do
    qr_code = RQRCode::QRCode.new("myQRCode")
    svg_string = RQRCode::Renderers::SVG::render(qr_code)
    assert svg_string.html_safe?
  end
end
