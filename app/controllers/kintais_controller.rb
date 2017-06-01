class KintaisController < ApplicationController
    require 'date'

    def new
        @kintai = Kintai.new
    end

    def create
        @kintai = Kintai.new(params[:kintai])
        @kintai.save

        redirect_to new_kintai_path
    end

end
