package com.unionpay.uppayplugin.demo;

import android.app.Activity;
import android.widget.TextView;
import com.unionpay.UPPayAssistEx;
import com.unionpay.uppay.PayActivity;

public class JARActivity extends BaseActivity {

    @Override
    public void doStartUnionPayPlugin(Activity activity, String tn, String mode) {
        UPPayAssistEx.startPayByJAR(activity, PayActivity.class, null, null,
                tn, mode);
    }

    @Override
    public void updateTextView(TextView tv) {
        String txt = "接入指南：\n1:拷贝sdk目录下的UPPayAssistEx.jar到libs目录下\n"
                + "2:根据需要拷贝sdk/jar/data.bin（或sdkPro/jar/data.bin）至工程的res/drawable目录下\n"
                + "3:根据需要拷贝sdk/jar/XXX/XXX.so（或sdkPro/jar/XXX/XXX.so）libs目录下\n"
                + "4:根据需要拷贝sdk/jar/UPPayPluginEx.jar（或sdkPro/jar/UPPayPluginExPro.jar）到工程的libs目录下\n"
                + "5:获取tn后通过UPPayAssistEx.startPayByJar(...)方法调用控件";
        tv.setText(txt);
    }
}
