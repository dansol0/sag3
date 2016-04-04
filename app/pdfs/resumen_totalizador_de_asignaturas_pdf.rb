class ResumenTotalizadorDeAsignaturasPdf < Prawn::Document

 
 def initialize(cantidad_de_postgrado, cantidad_de_pregrado, view)
	  super(:margin => [15,15,15,15])
	@cantidad_de_postgrado = cantidad_de_postgrado
	 @cantidad_de_pregrado = cantidad_de_pregrado
	   @view = view
	  bounding_box([8, cursor - 8],:width => 565,:height => 745) do
		  logo
			move_down 25
		  header ''
			move_down 60
		  body    
			move_down 380	                  
		  footer
		  transparent(0.5){ stroke_bounds }
		end
	    
	end

  def logo
    logopath =  "#{Rails.root}/app/assets/images/logo_pdf.jpg"
    image logopath, :width => 197, :height => 91
    move_down 10
  end

  def header (title=nil)
  	 text "Resumen totalizador de asignaturas de postgrado y pregrado", size: 15, style: :bold, align: :center
    move_down 30
    bounding_box([25, cursor - 0], :width => 180, :height => 30) do
    	move_down 10
    	span(500,:position =>:center)do
	    	
	    	text "Fecha de emisión: " + " " + Date.today.strftime("%d/%m/%Y"), :size => 10, style: :bold
		end
		transparent(0.5) { stroke_bounds }

    end
 

    if title
      text title, size: 14, style: :bold_italic, align: :center
    end
  end

  def body
  		
		  table(item_header, :cell_style => { :size => 12}, :width => 300,  :position => :center ) do
 				cells.padding = 4
				row(0).font_style= :bold
				row(0).size = 14
				columns(0..2).borders = [:right, :top, :left, :bottom]
			
				
				
				column(0).width = 80
				column(1).width = 220
				
				
				

				
			end

 end

 def item_header

 	[
 		["CANTIDAD", "Tipo de asignatura"],
 		["#{@cantidad_de_postgrado}", "Asignaturas de postgrado"],
 		["#{@cantidad_de_pregrado}", "Asignaturas de pregrado"]
 		
 	]


 end

 def footer
    text "© 2015 IDEC, Instituto de Desarrollo Experimental de la Construcción.", size: 8, style: :bold_italic, align: :center
  end
   


end