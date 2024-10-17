# frozen_string_literal: true

class FilesController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @file = ActiveStorage::Attachment.find_by(record_id: params[:id])
    return unless author?

    @file.purge
  end

  private

  def find_resource
    @resource = if @file.record_type == 'Answer'
                  Answer.find_by(id: params[:id])
                else
                  Question.find_by(id: params[:id])
                end
  end

  def author?
    find_resource
    current_user == @resource.author
  end
end
