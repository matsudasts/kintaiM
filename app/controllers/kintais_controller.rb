class KintaisController < ApplicationController

    def new
        @kintai = Kintai.new
    end

    def create
        hhmm = params[:kintai]["time_from"]
        #if  params[:kintai]["time_from"].present? && params[:kintai]["time_from"].length == 4
        #    if params[:kintai]["time_from"][0..1].to_i.between?(0, 23) && params[:kintai]["time_from"][2..3].to_i.between?(0, 59)
        # #       hhmm = params[:kintai]["time_from"][0..1] + params[:kintai]["time_from"][2..3]
        #    end
        #end
        #if !hhmm.present?
        #    errors.add("時間を4桁で入力して下さい。","")
        #elsif hhmm !~ /^[0-9]+$/
        #    errors.add("不正な時間です。","")
        #elsif !(hhmm[0..1].to_i).between?(0, 23) || !(hhmm[2..3].to_i).between?(0, 59)
        #    errors.add("不正な時間です。","")
        #else
            @kintai = Kintai.new(kintai_params)
            @kintai.kintai_year = params[:kintai]["kintai_from(1i)"]
            @kintai.kintai_month = format("%02d", params[:kintai]["kintai_from(2i)"])
            @kintai.kintai_day = format("%02d", params[:kintai]["kintai_from(3i)"])
            @kintai.kintai_from = (@kintai.kintai_year + @kintai.kintai_month + @kintai.kintai_day + hhmm).to_datetime
            @kintai.time_from = hhmm
       # end
    
        if @kintai.save
            flash[:msg] = "出勤時間を登録しました。"
            redirect_to new_kintai_path
        else
            return render :new
        end
    end

    def show 
    end

    def edit
        @kintai = Kintai.find(params[:id])
    end

    def update
        @kintai = Kintai.find(params[:id])
        @kintai.assign_attributes(kintai_params)

        if @kintai.save
            flash[:msg] = "出勤時間を編集しました。"
            redirect_to '/kintais/kintai_lists/' + @kintai.kintai_year.to_s + @kintai.kintai_month.to_s
        else
            render :edit
        end
    end

    def kintai_lists
        @kintai = Kintai.search_by_date(params[:kintai_date]).order_by_date
        render :index
    end

    def kintai_params
        params.require(:kintai).permit(
            :kintai_from,
            :kintai_year,
            :kintai_month,
            :kintai_day            
        )
    end
end
