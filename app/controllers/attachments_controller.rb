# frozen_string_literal: true

class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @file = ActiveStorage::Attachment.find_by!(record_id: params[:id])
    return unless current_user.author?(find_resource)

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
end
