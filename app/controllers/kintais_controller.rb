class KintaisController < ApplicationController
    require 'date'

    def create
        kintaiFrom = DateTime.now.hour.to_s + DateTime.now.minute.to_s

        @kintai = Kintai.new(kintai_date: Date.today, kintai_from: kintaiFrom)
        @kintai.save
    end

    def show
        kintaiFrom = DateTime.now.hour.to_s + DateTime.now.minute.to_s

        @kintai = Kintai.new(kintai_date: Date.today, kintai_from: kintaiFrom)
        @kintai.save
    end

end
