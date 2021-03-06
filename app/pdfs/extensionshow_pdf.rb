class ExtensionshowPdf < Prawn::Document

 
 def initialize(extension, view, user)
	  super(:margin => [15,15,15,15])
	  @extension = extension
	   @view = view
	   @user = user
	   bounding_box([8, cursor - 8],:width => 565,:height => 745) do
		  logo
			move_down 25
		  header ''
			move_down 30
		  body    
			move_down 220	                  
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
  	 text "ACTIVIDAD DEL ÁREA DE EXTENSIÓN", size: 15, style: :bold, align: :center
    move_down 30
     bounding_box([25, cursor - 0], :width => 400, :height => 100) do
    	move_down 10
    	span(500,:position =>:center)do
	    	text "Extensión", style: :bold, :size => 12
	    	move_down 10
	    	text "Actividad creada por:" + " " + "  #{@user.nombre1.upcase} #{@user.apellido1.upcase}", style: :bold, :size => 10
			move_down 10
			text "Fecha de emisión: " + " " + Date.today.strftime("%d/%m/%Y"), :size => 10, style: :bold
		end
		transparent(0.5) { stroke_bounds }

    end
   

    if title
      text title, size: 14, style: :bold_italic, align: :center
    end
  end

  def body
  		
  		text "ACTIVIDAD ID:  \##{@extension.id}", size: 13, style: :bold, :color =>"0000FF", align: :center
			 move_down 8  
		  data = [
		          		 ["TIPO", "#{@extension.tipo}"],
						 ["NOMBRE", "#{@extension.nombre}"],
						 ["DESCRIPCIÓN", "#{@extension.descripcion}"],
						 ["HORAS EMPLEADAS", "#{@extension.horas}"],
						 ["FECHA INICIO", "#{@extension.fecha_i}"],
						 ["FECHA DE CULMINACIÓN", "#{@extension.fecha_f}"],
						 ["PERIODO", "#{@extension.ano_periodo}"]
						 ]
					table(data,:column_widths =>[90, 430], :position =>:center,:row_colors =>["F0F0F0","FFFFFF"],:cell_style =>{:size => 10,:text_color =>"000000"})do
						  columns(0).font_style   = :bold
					end	 
				
  end

  def footer
    text "© 2015 IDEC, Instituto de Desarrollo Experimental de la Construcción.", size: 8, style: :bold_italic, align: :center
  end
   


end