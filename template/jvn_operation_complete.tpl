{#
 # JVN Vulnerability Infomation Managed System
 #
 # hidekuno@gmail.com
 #
 #}

{% include 'template/jvn_header.tpl' %}
    <div class="container-fluid">
      <div class="row">
        <div class="main">
          <h1 class="page-header">JVN ベンダー製品情報 編集依頼完了</h1>
          <center><h4 style="color:blue">以下製品を各担当者へメンテナンス依頼しました。</h4></center>
          <form name="execute_back" role="form" class="form-back" method="post" action="{{app.topuri}}/jvn_list/back">
            <button class="btn btn-lg btn-primary jvn-search" type="submit">
               <span class="glyphicon glyphicon-arrow-left"></span>戻る</button>
          </form>

          <div class="table-responsive">
            <table class="table table-striped">

              <thead>
                <tr>
                  <th>ベンダ名</th>
                  <th>製品名</th>
                  <th>cpe(/{種別}:{ベンダ名}:{製品名}:{バージョン}:{アップデート}:{エディション}:{言語})</th>
                </tr>
              </thead>

              <tbody>
                {% for item in app.result %}
                <tr>
                  <td>{{item[0]}}</td>
                  <td>{{item[1]}}</td>
                  <td>{{item[2]}}</td>
                </tr>
                {% endfor %}
              </tbody>

            </table>
          </div>
        </div>
      </div>
    </div>
    {% if app.error_message != '' %}
        <center><h4 style="color:red">{{ app.error_message }}</h4></center>
    {% endif %}
{% include 'template/jvn_footer.tpl' %}
