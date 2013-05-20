use Wx::Perl::Dialog;
package MyFrame;

sub new {

#检查为非有效用户时，弹出窗口供注册，返回值$reg为'Wx::TextCtrl'的输入内容：
my $reg= $self->ShowRegister($lic_ID);

}
### PUT SUBROUTINES HERE ###
sub ShowRegister {
    my ( $self, $lic_ID ) = @_;
    my $layout = [
        [
            [ 'Wx::StaticText', undef, "ID:", ],
            [
                'Wx::StaticText', undef, "$lic_ID,请向作者提供此ID号购买SN-KEY",
            ]
        ],
        [
            [ 'Wx::StaticText', undef, '请输入序列号SN-KEY：' ],
            [ 'Wx::TextCtrl', 'LICKEY', "$lic_ID" ],
        ],
        [
            [ 'Wx::Button', 'Ok', Wx::wxID_OK ],
            [ 'Wx::Button', 'Cancel', Wx::wxID_CANCEL ],
        ],
    ];

    my $dialog = Wx::Perl::Dialog->new(
        parent => $self,
        title => 'Register dialog',
        layout => $layout,
        width => [ 150, 400 ],
    );

    return if not $dialog->show_modal;
    my $data = $dialog->get_data;

    $self->{LICKEY} = $data->{LICKEY};
    return $self->{LICKEY};
}
