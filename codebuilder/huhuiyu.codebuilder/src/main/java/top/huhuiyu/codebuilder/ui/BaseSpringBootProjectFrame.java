package top.huhuiyu.codebuilder.ui;

import java.awt.Color;
import java.awt.Desktop;
import java.awt.Font;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JComponent;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.SwingConstants;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import top.huhuiyu.api.dbutils.datasource.DataSourceBuilder;
import top.huhuiyu.api.dbutils.datasource.DataSourceInfo;
import top.huhuiyu.api.dbutils.datasource.DriverInfo;
import top.huhuiyu.api.frame.FrameUtil;
import top.huhuiyu.api.frame.panel.GridBagPanel;
import top.huhuiyu.codebuilder.entity.RedisConfig;
import top.huhuiyu.codebuilder.utils.BuilderConfigInfo;
import top.huhuiyu.codebuilder.utils.CodeBuilder;

/**
 * SpringBoot项目基础类
 *
 * @author 胡辉煜
 */
public abstract class BaseSpringBootProjectFrame extends JFrame implements ActionListener {
  private static final long serialVersionUID = -7114032876846315672L;
  protected String templateConfig;
  private static final Logger log = LoggerFactory.getLogger(BaseSpringBootProjectFrame.class);
  private GridBagPanel gbp = new GridBagPanel(new Insets(10, 1, 10, 1));
  private JTextField tfProjectName = new JTextField(30);
  private JTextField tfPackageName = new JTextField(30);
  private JTextField tfAuthor = new JTextField(30);
  private JTextField tfOutputDir = new JTextField(25);
  private JTextField tfIp = new JTextField(30);
  private JTextField tfPort = new JTextField(30);
  private JTextField tfUsername = new JTextField(30);
  private JPasswordField tfPassword = new JPasswordField(30);
  private JTextField tfSchema = new JTextField(30);
  private JTextField tfDatabase = new JTextField(30);
  private JFileChooser jfc = new JFileChooser(System.getProperty("user.dir"));
  private JLabel lblError = new JLabel(" ");

  private JTextField tfRedis = new JTextField(30);
  private JTextField tfRedisHost = new JTextField(30);
  private JTextField tfRedisPort = new JTextField(30);
  private JPasswordField tfRedisPwd = new JPasswordField(30);

  private JButton btnBuild = new JButton("开始生成");
  private JButton btnBrowser = new JButton("浏览...");
  private JComboBox<String> cbDataSource = new JComboBox<>();
  private DataSourceBuilder dataSourceBuilder = new DataSourceBuilder();
  private List<DriverInfo> drivers;

  public BaseSpringBootProjectFrame(String templateConfig) {
    super();
    this.templateConfig = templateConfig;
    // 初始化
    Map<String, DriverInfo> datasourMap = dataSourceBuilder.getDriverInfoMap();
    drivers = new ArrayList<>();
    for (String key : datasourMap.keySet()) {
      // 暂时只要mysql
      if ("oracle".equals(key) || "mssql".equals(key)) {
        continue;
      }
      drivers.add(datasourMap.get(key));
    }
    lblError.setForeground(Color.RED);
    // 界面=================================================
    this.add(gbp);
    ui();
    // 数据=================================================
    for (DriverInfo driver : drivers) {
      cbDataSource.addItem(String.format("%s(%s)", driver.getDescription(), driver.getName()));
    }
    // 事件=================================================
    jfc.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
    jfc.setMultiSelectionEnabled(false);
    btnBrowser.addActionListener(this);
    btnBuild.addActionListener(this);
    // 启动=================================================
    FrameUtil.setEnterToFocus(this);
    FrameUtil.setComponentsFont(gbp, JComponent.class, new Font(null, Font.BOLD, 18));
    this.pack();
    this.setResizable(false);
    this.setDefaultCloseOperation(DISPOSE_ON_CLOSE);
    this.setVisible(true);
  }

  /**
   * 设置默认信息
   * 
   * @param parameter TODO
   */
  public void setDefaultInfo(DefaultInfoParameter parameter) {
    tfProjectName.setText(parameter.getProject());
    tfPackageName.setText(parameter.getPackageName());
    tfAuthor.setText(parameter.getAuthor());
    tfIp.setText(parameter.getIp());
    tfPort.setText(parameter.getPort());
    tfUsername.setText(parameter.getUsername());
    tfPassword.setText(parameter.getPassword());
    tfDatabase.setText(parameter.getDatabase());
    tfOutputDir.setText(parameter.getOutputDir());

    tfRedis.setText(parameter.getRedisDatabase());
    tfRedisHost.setText(parameter.getRedisHost());
    tfRedisPort.setText(parameter.getRedisPort());
    tfRedisPwd.setText(parameter.getRedisPassword());
  }

  private void ui() {
    int row = 0;
    tfOutputDir.setEditable(false);
    gbp.addComponent(new JLabel("项目名称：", SwingConstants.RIGHT), row, 1);
    gbp.addComponent(tfProjectName, row, 2, 2, 1);
    row++;
    gbp.addComponent(new JLabel("基础包名称：", SwingConstants.RIGHT), row, 1);
    gbp.addComponent(tfPackageName, row, 2, 2, 1);
    row++;
    gbp.addComponent(new JLabel("作者名称：", SwingConstants.RIGHT), row, 1);
    gbp.addComponent(tfAuthor, row, 2, 2, 1);
    row++;
    gbp.addComponent(new JLabel("输出目录：", SwingConstants.RIGHT), row, 1);
    gbp.addComponent(tfOutputDir, row, 2);
    gbp.addComponent(btnBrowser, row, 3);
    row++;
    gbp.addComponent(new JLabel("数据源类型：", SwingConstants.RIGHT), row, 1);
    gbp.addComponent(cbDataSource, row, 2, 2, 1);
    row++;
    gbp.addComponent(new JLabel("数据库ip地址：", SwingConstants.RIGHT), row, 1);
    gbp.addComponent(tfIp, row, 2, 2, 1);
    row++;
    gbp.addComponent(new JLabel("数据库端口：", SwingConstants.RIGHT), row, 1);
    gbp.addComponent(tfPort, row, 2, 2, 1);
    row++;
    gbp.addComponent(new JLabel("数据库用户名：", SwingConstants.RIGHT), row, 1);
    gbp.addComponent(tfUsername, row, 2, 2, 1);
    row++;
    gbp.addComponent(new JLabel("数据库密码：", SwingConstants.RIGHT), row, 1);
    gbp.addComponent(tfPassword, row, 2, 2, 1);
    row++;
    gbp.addComponent(new JLabel("schema：", SwingConstants.RIGHT), row, 1);
    gbp.addComponent(tfSchema, row, 2, 2, 1);
    row++;
    gbp.addComponent(new JLabel("数据库名：", SwingConstants.RIGHT), row, 1);
    gbp.addComponent(tfDatabase, row, 2, 2, 1);
    row++;
    gbp.addComponent(new JLabel("redis数据库序号：", SwingConstants.RIGHT), row, 1);
    gbp.addComponent(tfRedis, row, 2, 2, 1);
    row++;
    gbp.addComponent(new JLabel("redis数据库ip地址：", SwingConstants.RIGHT), row, 1);
    gbp.addComponent(tfRedisHost, row, 2, 2, 1);
    row++;
    gbp.addComponent(new JLabel("redis数据库端口：", SwingConstants.RIGHT), row, 1);
    gbp.addComponent(tfRedisPort, row, 2, 2, 1);
    row++;
    gbp.addComponent(new JLabel("redis数据库密码：", SwingConstants.RIGHT), row, 1);
    gbp.addComponent(tfRedisPwd, row, 2, 2, 1);
    row++;
    gbp.addComponent(btnBuild, row, 1, 3, 1);
    row++;
    gbp.addComponent(lblError, row, 1, 3, 1);
  }

  private void build() {
    dataSourceBuilder.setInfo(tfDatabase.getText().trim(), tfIp.getText().trim(), tfPort.getText().trim(), tfUsername.getText().trim(), new String(tfPassword.getPassword()).trim(),
        tfSchema.getText().trim());
    DataSourceInfo dataSourceInfo = dataSourceBuilder.getDataSourceInfo(drivers.get(cbDataSource.getSelectedIndex()));
    BuilderConfigInfo baseConfigInfo = new BuilderConfigInfo();
    baseConfigInfo.setAuthor(tfAuthor.getText().trim());
    baseConfigInfo.setOutputDir(tfOutputDir.getText().trim());
    baseConfigInfo.setPackageName(tfPackageName.getText().trim());
    baseConfigInfo.setProjectName(tfProjectName.getText().trim());
    RedisConfig redisConfig = new RedisConfig(tfRedis.getText(), tfRedisHost.getText(), tfRedisPort.getText(), new String(tfRedisPwd.getPassword()).trim());
    CodeBuilder codeBuilder = CodeBuilder.getInstance(dataSourceInfo, templateConfig, tfSchema.getText().trim(), baseConfigInfo, redisConfig);
    List<File> files = codeBuilder.build();
    for (File file : files) {
      log.debug(String.format("输出：%s", file));
    }
    JOptionPane.showMessageDialog(BaseSpringBootProjectFrame.this, "输出完成");
    try {
      Desktop.getDesktop().open(new File(tfOutputDir.getText()));
    } catch (IOException ex) {
      log.error("打开文件错误", ex);
    }
  }

  @Override
  public void actionPerformed(ActionEvent e) {
    if (e.getSource() == btnBrowser) {
      int result = jfc.showOpenDialog(BaseSpringBootProjectFrame.this);
      if ((result == JFileChooser.APPROVE_OPTION) && (jfc.getSelectedFile() != null)) {
        tfOutputDir.setText(jfc.getSelectedFile().getAbsolutePath());
      }
    } else if (e.getSource() == btnBuild) {
      log.debug("" + drivers.get(cbDataSource.getSelectedIndex()));
      lblError.setText(" ");
      if ("".equals(tfProjectName.getText().trim())) {
        lblError.setText("项目名称必须填写");
        return;
      }
      if ("".equals(tfPackageName.getText().trim())) {
        lblError.setText("基础包必须填写");
        return;
      }
      if ("".equals(tfAuthor.getText().trim())) {
        lblError.setText("作者必须填写");
        return;
      }
      if ("".equals(tfOutputDir.getText().trim())) {
        lblError.setText("请选择输出目录");
        return;
      }
      if ("".equals(tfIp.getText().trim())) {
        lblError.setText("数据库ip必须填写");
        return;
      }
      if ("".equals(tfPort.getText().trim())) {
        lblError.setText("数据库端口必须填写");
        return;
      }
      if ("".equals(tfUsername.getText().trim())) {
        lblError.setText("数据库用户名必须填写");
        return;
      }
      if ("".equals(new String(tfPassword.getPassword()).trim())) {
        lblError.setText("数据库密码必须填写");
        return;
      }
      if ("".equals(tfDatabase.getText().trim())) {
        lblError.setText("数据库名必须填写");
        return;
      }
      build();
    }
  }
}
