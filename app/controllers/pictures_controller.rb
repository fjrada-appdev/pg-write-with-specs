class PicturesController < ApplicationController
  def recent
    @photos = Photo.all.order({ :created_at => :desc }).limit(25)

    render("pic_templates/time_list.html.erb")
  end

  def most_liked
    @photos = Photo.all.order({ :likes_count => :desc }).limit(25)

    render("pic_templates/liked_list.html.erb")
  end

  def show_details
    photo_id = params.fetch("some_id")

    @pic = Photo.where({ :id => photo_id }).at(0)

    render("pic_templates/details.html.erb")
  end
  
  def delete_photo
    photo = Photo.where(:id => params.fetch(:id)).first
    photo.destroy
    
    redirect_to("/popular")
    
  end
  
  def new_photo_form
    
    
    render("/pic_templates/new_photo_form")
  end
  
  def create_photo_record
    p = Photo.new
    
    p.caption = params.fetch(:pic_caption)
    p.image = params.fetch(:pic_image)
    p.owner_id = params.fetch(:poster_id).to_i
    
    p.save
    redirect_to("/recent")
  end
  
  def edit_photo
    photo_id = params.fetch(:id)
    @photo = Photo.where(:id => photo_id ).first
    
    render("/pic_templates/edit_photo_form.html.erb")
  end
  
  def update_photo_record
     photo_id = params.fetch(:id)
    p = Photo.where(:id => photo_id ).first
    
    p.caption = params.fetch(:pic_caption)
    p.image = params.fetch(:pic_image)
    p.save
    
    redirect_to("/photos/#{photo_id}")
  end
end
