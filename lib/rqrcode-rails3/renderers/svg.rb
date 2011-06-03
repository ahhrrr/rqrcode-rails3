module RQRCode
  module Renderers
    class SVG
      class << self
        # Render the SVG from the qrcode string provided from the RQRCode gem
        #   Options:
        #   offset            - Padding around the QR Code (e.g. 10)
        #   fill              - Background color (e.g "ffffff" or :white)
        #   color             - Foreground color for the code (e.g. "000000" or :black)
        #   module_dimension  - The dimension of each module in the QR code in pixels (e.g. 11)

        def render(qrcode, options={})
          offset           = options[:offset].to_i      || 0
          color            = options[:color]            || "000"
          module_dimension = options[:module_dimension] || 11

          # height and width dependent on offset and QR complexity
          dimension = (qrcode.module_count*module_dimension) + (2*offset)

          xml_tag   = %{<?xml version="1.0" standalone="yes"?>}
          open_tag  = %{<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:ev="http://www.w3.org/2001/xml-events" width="#{dimension}" height="#{dimension}">}
          close_tag = "</svg>"

          result = []
          qrcode.modules.each_index do |c|
            tmp = []
            qrcode.modules.each_index do |r|
              y = c*module_dimension + offset
              x = r*module_dimension + offset

              next unless qrcode.is_dark(c, r)
              tmp << %{<rect width="#{module_dimension}" height="#{module_dimension}" x="#{x}" y="#{y}" style="fill:##{color}"/>}
            end 
            result << tmp.join
          end
          
          if options[:fill]
            result.unshift %{<rect width="#{dimension}" height="#{dimension}" x="0" y="0" style="fill:##{options[:fill]}"/>}
          end
          
          svg = [xml_tag, open_tag, result, close_tag].flatten.join("\n")
        end
      end
    end
  end
end

