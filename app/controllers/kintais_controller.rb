class KintaisController < ApplicationController

    def new
        byebug
        kintai = Kintai.where("kintai_date=?", Time.now.to_date)[0]
        if kintai.present?
            redirect_to edit_kintai_path(kintai.id)
        else
            @kintai = Kintai.new
            @kintai.kintai_date = Time.now.strftime('%Y-%m-%d')
            @kintai.kintai_from = Time.now.strftime('%Y-%m-%d')
            @kintai.kintai_to = Time.now.strftime('%Y-%m-%d')
        end
    end

    def create
        @kintai = Kintai.new(kintai_params)
        @kintai.kintai_date = params[:kintai]["kintai_date"].to_date
        @kintai.kintai_year = params[:kintai]["kintai_date"][0..3]
        @kintai.kintai_month = params[:kintai]["kintai_date"][5..6]
        @kintai.kintai_day = params[:kintai]["kintai_date"][8..9]
        # 時間がずれるので、9時間引いて登録
        @kintai.kintai_from = get_kintai_date_from()
        @kintai.kintai_to = get_kintai_date_to()        

        if @kintai.save
            flash[:msg] = params[:kintai]["kintai_date"].to_date.strftime('%m月%d日').to_s + "の勤怠を登録しました。"
            redirect_to new_kintai_path
        else
            render :new
        end
    end

    def edit
        @kintai = Kintai.find(params[:id])
    end

    def update
        @kintai = Kintai.find(params[:id])
        @kintai.assign_attributes(kintai_params)
        if @kintai.save
            flash[:msg] = params[:kintai]["kintai_date"].to_date.strftime('%m月%d日').to_s + "の勤怠を編集しました。"
            redirect_to new_kintai_path
        else
            render :edit
        end
    end

    def get_kintai
        kintai = Kintai.where("kintai_date=?",params[:kintai_date])[0]
        if kintai.present?
            redirect_to edit_kintai_path(kintai.id)
        else
            redirect_to new_kintai_path
            #@kintai = Kintai.new
            #@kintai.kintai_date = "2017-01-01"
            #@kintai.kintai_from = Time.now.strftime('%Y/%m/%d')
            #@kintai.kintai_to = Time.now.strftime('%Y/%m/%d')
            #render :new         
        end
    end

    def exists_kintai
        kintai = Kintai.where("kintai_date=?",params[:kintai_date])[0]
        if kintai.present?
            byebug
            true
        else
            false
        end
    end

    def kintai_lists
        @kintai = Kintai.search_by_month(params[:kintai_date_from_disp]).order_by_date
        render :index
    end

    def kintai_params
        params.require(:kintai).permit(
            :kintai_from,
            :kintai_to,            
            :kintai_year,
            :kintai_month,
            :kintai_day,
            :kintai_date
        )
    end

    private
    def get_kintai_date_from
        (params[:kintai]["kintai_from"][0..3] + 
         params[:kintai]["kintai_from"][5..6] + 
         params[:kintai]["kintai_from"][8..9] +
         params[:kintai]["kintai_from(4i)"] + 
         params[:kintai]["kintai_from(5i)"]).to_datetime - 0.375
    end

    def get_kintai_date_to
        (params[:kintai]["kintai_to"][0..3] + 
         params[:kintai]["kintai_to"][5..6] + 
         params[:kintai]["kintai_to"][8..9] +
         params[:kintai]["kintai_to(4i)"] + 
         params[:kintai]["kintai_to(5i)"]).to_datetime - 0.375
    end

    def get_registered_kintai_from(yyyymmdd)
        kintai = Kintai.where("kintai_date = ?", yyyymmdd.to_date)

        if kintai.exists?
            kintai[0].kintai_date.to_s[0..3] + "/" + kintai[0].kintai_date.to_s[5..6] + "/" + 
            kintai[0].kintai_date.to_s[8..9]
        else
            yyyymmdd
        end
    end
end
