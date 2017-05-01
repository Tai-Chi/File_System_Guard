require 'java'

module M
  include_package "javax.swing"
  include_package "java.awt"
  include_package "java.lang"
end

=begin
frame = M::JFrame.new("JFrame Source Demo");
jlbempty = M::JLabel.new("");
jlbempty.setPreferredSize(M::Dimension.new(175, 100));
frame.getContentPane().add(jlbempty, M::BorderLayout::CENTER);
frame.pack();
frame.setVisible(true);
frame.setDefaultCloseOperation(M::JFrame::EXIT_ON_CLOSE)
=end

M::System.out.println("OUTPUT HAHA~~")
