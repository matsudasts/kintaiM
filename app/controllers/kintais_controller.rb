class KintaisController < ApplicationController
    require 'date'

    def new
        @kintai = Kintai.new
    end

    def create
        kintaiFrom = DateTime.now.hour.to_s + DateTime.now.minute.to_s

        @kintai = Kintai.new(kintai_date: Date.today, kintai_from: kintaiFrom)
        @kintai.save

        redirect_to "top/index"
    end

end
