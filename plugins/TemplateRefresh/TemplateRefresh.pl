# TemplateRefresh plugin for Movable Type
# Author: Nick O'Neill and Brad Choate, Six Apart (http://www.sixapart.com)
# Released under the Artistic License
#
# $Id$

package MT::Plugin::TemplateRefresh;

use strict;
use MT;
use base qw(MT::Plugin);

sub BEGIN {
    MT->add_plugin(new MT::Plugin::TemplateRefresh({
        name => "Template Backup and Refresh",
        author_name => 'Six Apart, Ltd.',
        author_link => 'http://www.sixapart.com/',
        description => "<MT_TRANS phrase=\"Backup and refresh existing templates to Movable Type's default templates.\">",
        version => 1.1,
    }));
}

sub init_app {
    my $plugin = shift;
    $plugin->SUPER::init_app(@_);
    my ($app) = @_;

    if ($app->isa('MT::App::CMS')) {
        $app->add_itemset_action({type => 'blog',
                                  key => "refresh_blog_templates",
                                  label => "Refresh Template(s)",
                                  code => sub { $plugin->refresh_blog_templates(@_) },
                               });
        $app->add_itemset_action({type => 'template',
                                  key => "refresh_tmpl_templates",
                                  label => "Refresh Template(s)",
                                  code => sub { $plugin->refresh_individual_templates(@_) },
                                  condition => sub { $plugin->perm_check($app) },
                               });
    }
}

sub perm_check {
    my $plugin = shift;
    my ($app) = @_;
    my $perms = $app->{perms};
    $perms ? $perms->can_edit_templates : $app->user->is_superuser;
}

sub default_dictionary {
    # sha1 signatures for all default templates
    # we use these to determine if user has altered their templates;
    # if so, we backup the original, if not, we overwrite it
    my $dict = {};

    eval q[
    # 1.1
    $dict->{'index'}{'Main Index'}{'407110d0415eb2124fa1aa7fcec4a5cc0bebba82'} = 1;
    $dict->{'index'}{'XML RSS Index'}{'59f5ecc2753251c43340b82213c7e16623c0410f'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'5770ee182268b0cfb12ef9b1e66caa7d6406e4d8'} = 1;
    $dict->{'archive'}{'Date-Based Archive Template'}{'c01c93248e62619772298ccaf99fd4310bc11ea8'} = 1;
    $dict->{'category'}{'Category Archive Template'}{'c01c93248e62619772298ccaf99fd4310bc11ea8'} = 1;
    $dict->{'individual'}{'Individual Entry Archive Template'}{'c32c51426c660fc865929ab6a043869b8a3d3e85'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'e6377a7ad2f550a94ca36b9bc09dd7204783a37e'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'d4c0d0290912320805f04ff15832ac1a6fc80af6'} = 1;

    # 1.2
    $dict->{'index'}{'Main Index'}{'4dc91ae495205f70d87ee3b6f2162e86fb5731a8'} = 1;
    $dict->{'index'}{'XML RSS Index'}{'59f5ecc2753251c43340b82213c7e16623c0410f'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'5770ee182268b0cfb12ef9b1e66caa7d6406e4d8'} = 1;
    $dict->{'archive'}{'Date-Based Archive Template'}{'c01c93248e62619772298ccaf99fd4310bc11ea8'} = 1;
    $dict->{'category'}{'Category Archive Template'}{'c01c93248e62619772298ccaf99fd4310bc11ea8'} = 1;
    $dict->{'individual'}{'Individual Entry Archive Template'}{'c32c51426c660fc865929ab6a043869b8a3d3e85'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'e6377a7ad2f550a94ca36b9bc09dd7204783a37e'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'d4c0d0290912320805f04ff15832ac1a6fc80af6'} = 1;
    $dict->{'popup_image'}{'Uploaded Image Popup Template'}{'71b0a469d94db802f03aa69965415dea137ace06'} = 1;

    # 1.31
    $dict->{'index'}{'Main Index'}{'816f80828d83fcc7ef6170459929f7cccc999c61'} = 1;
    $dict->{'index'}{'XML RSS Index'}{'6743a150c8eb9f90a44df7c45920a1cd4693b80d'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'5e1279912e02f5c20d58d50f5b47dc3c08e02c43'} = 1;
    $dict->{'archive'}{'Date-Based Archive Template'}{'c01c93248e62619772298ccaf99fd4310bc11ea8'} = 1;
    $dict->{'category'}{'Category Archive Template'}{'c01c93248e62619772298ccaf99fd4310bc11ea8'} = 1;
    $dict->{'individual'}{'Individual Entry Archive Template'}{'1edf13dc974b75c9f0580e6f298a9046fd536dd3'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'e6377a7ad2f550a94ca36b9bc09dd7204783a37e'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'d5bd507c47d953167cc949c914b2e708af414474'} = 1;
    $dict->{'popup_image'}{'Uploaded Image Popup Template'}{'71b0a469d94db802f03aa69965415dea137ace06'} = 1;

    # 1.4
    $dict->{'index'}{'Main Index'}{'879245bcd891fe2ce9d69d97e7f2892b3011e45a'} = 1;
    $dict->{'index'}{'XML RSS Index'}{'6743a150c8eb9f90a44df7c45920a1cd4693b80d'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'ed2babcbd627bae187b72e8a7ca7de1b63c6c6c5'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'ce6914e66298009da5dc1275f9e7f3792f39eedb'} = 1;
    $dict->{'popup_image'}{'Uploaded Image Popup Template'}{'71b0a469d94db802f03aa69965415dea137ace06'} = 1;
    $dict->{'index'}{'Stylesheet'}{'846a2bc52a437dbd7424fed900ccf0abd42c1c33'} = 1;
    $dict->{'archive'}{'Date-Based Archive Template'}{'2b8698c7260f48fc9e0c06fa1400756eff6430fc'} = 1;
    $dict->{'category'}{'Category Archive Template'}{'d4e902c451f53966b067d118ed2883e697fdc02a'} = 1;
    $dict->{'individual'}{'Individual Entry Archive Template'}{'a2957010ed5c5b8e11e98f1e463860063d8fc7eb'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'a1980ad808894996c7b50e88ca29a66f969e8870'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'7e7807d1400f569593c7abeba423f3be3357f826'} = 1;

    # 2.0
    $dict->{'index'}{'Main Index'}{'76f902f398a10f3728a76027f962bb9f2ce84ff4'} = 1;
    $dict->{'index'}{'RSS 0.91 Index'}{'6743a150c8eb9f90a44df7c45920a1cd4693b80d'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'29987f5f7ba64bf30f5b36ea3ad3bc1b66f028f8'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'a1980ad808894996c7b50e88ca29a66f969e8870'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'ce6914e66298009da5dc1275f9e7f3792f39eedb'} = 1;
    $dict->{'popup_image'}{'Uploaded Image Popup Template'}{'71b0a469d94db802f03aa69965415dea137ace06'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'7e7807d1400f569593c7abeba423f3be3357f826'} = 1;
    $dict->{'index'}{'RSS 1.0 Index'}{'108ae4976884ad68fb85042c63b101e8d6b67068'} = 1;
    $dict->{'index'}{'Stylesheet'}{'846a2bc52a437dbd7424fed900ccf0abd42c1c33'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'92ed95ad9e80e25c977b95cc161468d736a8dfc2'} = 1;
    $dict->{'category'}{'Category Archive'}{'b1833e03af47af1e8648186098584152d49e18df'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'0d50f720a92bad17746bddaf945ac3023c5b97f6'} = 1;

    # 2.11
    $dict->{'index'}{'Main Index'}{'317217b27900666d12d1abf9dc74fb8c8e2bebf0'} = 1;
    $dict->{'index'}{'RSS 0.91 Index'}{'5429e642862a459adc0d6520f610c7113faa211f'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'c257052cf28bfc3ddf9f2ee6ad89a1b83e754906'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'55ae4e949428a927c7f48ba013e49a565bb57880'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'b154c876d3b629103a21add608201b9a9595772e'} = 1;
    $dict->{'popup_image'}{'Uploaded Image Popup Template'}{'71b0a469d94db802f03aa69965415dea137ace06'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'a5c451d553f7736f4cafb6c61bf1ad0170727721'} = 1;
    $dict->{'index'}{'RSS 1.0 Index'}{'678c192ee6cddfdf8b13b1c30cb3ef5e2bbf7ca6'} = 1;
    $dict->{'index'}{'Stylesheet'}{'4d62b1ecdea486e234a1fba1bceeb777713c467a'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'92332c5acbd58a5e2c67418252c6922a7e412792'} = 1;
    $dict->{'category'}{'Category Archive'}{'f58abd34ef257d693f70d12c4b3bbdf102c943b6'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'b201aa4eeaf2c113d033753e3db9f37ea1096c04'} = 1;

    # 2.21
    $dict->{'index'}{'Main Index'}{'ba7bce3d5ea6e7f247c4e88c32465c85bd02242d'} = 1;
    $dict->{'index'}{'RSS 0.91 Index'}{'19abb8489f1703226e2081ce47818151fc1e1533'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'07234b049e1a319f76c0099724a18cedb7af7a82'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'55ae4e949428a927c7f48ba013e49a565bb57880'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'b154c876d3b629103a21add608201b9a9595772e'} = 1;
    $dict->{'popup_image'}{'Uploaded Image Popup Template'}{'71b0a469d94db802f03aa69965415dea137ace06'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'a5c451d553f7736f4cafb6c61bf1ad0170727721'} = 1;
    $dict->{'index'}{'RSS 1.0 Index'}{'72afff93eb20e4ee9ac68342e265e5b2eea043a9'} = 1;
    $dict->{'index'}{'Stylesheet'}{'3ed7a660665db0fdfd34223fa7677b4268fe5eee'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'6c505b012093710d942ad45da55456407f063ecb'} = 1;
    $dict->{'category'}{'Category Archive'}{'d3d2e9c7767ed0e5443f92fde96679486da26968'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'ab71eb8782a242ff74fe0d73a5122bf74c3b6ccc'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'091fa8912983f9f83adea54089cd3ec69e44f335'} = 1;

    # 2.51
    $dict->{'index'}{'Main Index'}{'f650d9b711be71f4986834c23033e52ae3f134e1'} = 1;
    $dict->{'index'}{'RSS 0.91 Index'}{'26faba6fe7b65b57a8bd8e99679407dc06c301ff'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'b523cd4f0e588abaf869694f5e9f4a08394d79dd'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'e80238e281bb77b4891baf2bdd1934fd275b002a'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'b4262b19482af08373b92979abf6e5b1e963e6d8'} = 1;
    $dict->{'popup_image'}{'Uploaded Image Popup Template'}{'71b0a469d94db802f03aa69965415dea137ace06'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'7305e3b33b834ae6aa64b22dd18cb55f1e091cbd'} = 1;
    $dict->{'index'}{'RSS 1.0 Index'}{'c4e641a020ba037307e473976974db94ca0058e9'} = 1;
    $dict->{'index'}{'Stylesheet'}{'d8264261da0fb212c8e2e20d34c8f8dc6ce25422'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'7875e9fc58524dfe2d5e1fd94182b3f721f7d3e6'} = 1;
    $dict->{'category'}{'Category Archive'}{'e0a6ae9184ef388988d92c1aa86125cc0ab31550'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'ad2a6232d8db895c994a91b19da844def6a5680b'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'46eb8b1c552d783d3ef7941b38be0899571147db'} = 1;

    # 2.661
    $dict->{'index'}{'Main Index'}{'cff7cd6b841e5784d931c87c93f3c428626f67e6'} = 1;
    $dict->{'index'}{'RSD'}{'287880a4c3840625053077b6334d91c345acd2e4'} = 1;
    $dict->{'index'}{'Atom Index'}{'ecdfb3afb486e634d9438bf0af2e9db47e3a8cf5'} = 1;
    $dict->{'index'}{'RSS 2.0 Index'}{'b2ebbc25310c57b0cf85ae1d2566193fc7ba72c3'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'31f1cd87d6590215dc6babc66809ad6c5ed19a28'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'e1c70ed21317c97c8c951ed3bf3279f888635e19'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'cfc5d39862e2cb625596f9e0fb0add633fd3fc7a'} = 1;
    $dict->{'popup_image'}{'Uploaded Image Popup Template'}{'71b0a469d94db802f03aa69965415dea137ace06'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'5ab05a3b442ffd5e1d98766e7f1eb7bc0dd89cc3'} = 1;
    $dict->{'index'}{'RSS 1.0 Index'}{'587c576c4df2053bdade147c2eed06676fb57373'} = 1;
    $dict->{'index'}{'Stylesheet'}{'d47f2fc739944385d1f2486d0d34ee129d47c746'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'0f4007fe393b99633d5948927f53033eefd4a0f2'} = 1;
    $dict->{'category'}{'Category Archive'}{'908855e015ad1934353550ecd2c640aa9192a53d'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'968646f67c9afda99ac0e0b4e7e85c63fe088ed0'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'7383112b177902906236e8943890104a9c77344a'} = 1;

    # 3.16
    $dict->{'index'}{'Main Index'}{'257e3d22a3682e9e86aa2d9be53af1e4c9abbbc7'} = 1;
    $dict->{'index'}{'Main Index'}{'4b2e54a6cc5917428b3fb48fb36414a42a5920a6'} = 1;
    $dict->{'index'}{'Main Index'}{'505f1d363a314ef2da488c157a374d6e00c58d57'} = 1;
    $dict->{'index'}{'Main Index'}{'654bcea62270e62de2a28ecc0dd899c8887a69f2'} = 1;
    $dict->{'index'}{'Main Index'}{'78a47d6748c87ad110ef0bead8838a09f26e81a4'} = 1;
    $dict->{'index'}{'Main Index'}{'e7a7a2c704f18d87e723bfffaf5bef04a1dc91dd'} = 1;
    $dict->{'index'}{'Dynamic Site Bootstrapper'}{'2143a746f4f73d9515ca9ab94f3241ca12d17306'} = 1;
    $dict->{'index'}{'RSD'}{'287880a4c3840625053077b6334d91c345acd2e4'} = 1;
    $dict->{'index'}{'Atom Index'}{'b72c5bbb48d9129ea39383e14b98286128952ade'} = 1;
    $dict->{'index'}{'RSS 2.0 Index'}{'81c3335d388f2f69d6311ad4eb6ec344b654684f'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'2214c531eb49879641f1756311e0892f0399a702'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'4fbea20e8866041a59473c23968165499ca58263'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'9c6505c0f818e0f3347797939745f645414b3f47'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'a7851e7e1df743e7697ce987050c6cefe6757295'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'bcb285fdb914d77d1f64f9bdfd93440f3a32720a'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'24a9f9c9aa0ba6d6741dc68e10ed5be406d67df8'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'785529e76220b7ff2028ba216f5845f981ca7d7d'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'82caa3186da19bcea245f653618a0187e2634137'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'94a7cb5c4fe76bdae83d3757b4cf2c3e702df34e'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'ea173dfc883944776432dd24a103cb7b68e097b4'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'fc4cb69b72fbeb8e9cd83886a5ced4f258b8693b'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Message'}{'26eeb357eb88eaf0f750a345b850d59f3f604556'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Message'}{'5c43581ac1a2ce853f4196ba08c6a31b662cd1d1'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Message'}{'8665ead2344f283b1cb7418b9a68dca75876c27b'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Message'}{'951151dc04e6b9ccfdddb9897b3f8c02f3545c6c'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Message'}{'aadde51bddbb40aba343fb9582d4d2cad87fa3e8'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Message'}{'ee85c8685ac1da0841ba3e8a3bf48f6f9665800a'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'30653dc0cb616ae26770cdbd866883ffb2fc0ec9'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'42558b4feda5735b6e9d483fa6765ba094ed6d5e'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'957ca0607d478f8caba7a3e1ba2397d9cd37885f'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'a9d7ebf9d0acd5f2fc8a393591b6b38f09c6b740'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'af1975d66189367b15cec61e342a2b0e23cc9cbd'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'b99d721f630aa2728bea73de47f6cdd87e95ad6c'} = 1;
    $dict->{'popup_image'}{'Uploaded Image Popup Template'}{'f159c35e14a46fe206bf8907bffbb16447cad15c'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'64da0621324294f6c9c3341c31c0c941f35e3b57'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'92ed4e477d08086e5efc2ded4502c08ff98b9f64'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'9d687512b3b2bfc9cb976c903046a579ab887374'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'c41bf5b92366ce227689953f1cae14824cdd54ef'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'e71b31aebef0475e8c6a8e8de0fd47baec1445d9'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'ef9e2dfdf5e99522068456c1871a1d01aaacd2d3'} = 1;
    $dict->{'dynamic_error'}{'Dynamic Pages Error Template'}{'ff3a52b390df5ec6aacdec43112bd047413b4c8c'} = 1;
    $dict->{'index'}{'RSS 1.0 Index'}{'2ff7ed6dc4f509ead2407b6ea3e3f350f28b25bd'} = 1;
    $dict->{'index'}{'Stylesheet'}{'e37a1b39e4c974bf0f3e79dddbf1e855edd0bdca'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'1bd4a4984845a41ad3b8a7303b5b4560daa84752'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'445a90339da5320f442ecc40d7271b574797677a'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'484a36f54c0968b2dbe336845e04307b5e20aa85'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'75936096e7d46e0e3f7c06c9df86f69a12b94768'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'edeed36ce2b0d6d0ff8052f6cf7f4116f39ac1ab'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'f3ef091689d36fc9826200bd55ed21d85a8c53ed'} = 1;
    $dict->{'category'}{'Category Archive'}{'26e7859c15812790454b99de1d3887d0a8e8e6ff'} = 1;
    $dict->{'category'}{'Category Archive'}{'3454326c2552bc1b5bfd1b542ec3ab6c87fb2c43'} = 1;
    $dict->{'category'}{'Category Archive'}{'39096f7db2d393ed66df7de855b9841a90c95485'} = 1;
    $dict->{'category'}{'Category Archive'}{'c0358a683783d625249e9b57075d4d0e6c04cfa7'} = 1;
    $dict->{'category'}{'Category Archive'}{'d178ce949a06690f5c83aa519d801a674430c15c'} = 1;
    $dict->{'category'}{'Category Archive'}{'e81f09062b54027bcd316594c3b945378f0f1347'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'4fcff69ba6afdbcf734ee7c4542cd706a6afdc35'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'551c79d951c8b31a24993a2d9e82fe8b00c2cb3f'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'5a07a70562ecee1aacfb2c2edfd77d1cc7cbf2c6'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'61b03a841e5bb5d2dad7794c068edcaa375853fd'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'855be3df1a0ea28b93bcfc859ed4a9ad723169cc'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'9d01472a423315728d78fcf7e356dbb818ed9ad5'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'0eef136c91c29bb85a2e3679b6edb5cbcdad843d'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'5e894b4ee8fcda2023c7fd38af6d26227f00c59a'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'6a00c296985925588567d31029ad3bb6e018f6ed'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'7a9681c99d268c7c191c373e7e5e7ff7634e7dd3'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'cef4ada361d56ab4387be0c890d0be861ee9bf66'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'fba39a64ad0d8b65344eba4e7f9ca48c8cdb2e3c'} = 1;
    $dict->{'custom'}{'Remember Me'}{'7a644226fb29adec3d541a88d52d792e5672710d'} = 1;

    # 3.17
    $dict->{'index'}{'Main Index'}{'257e3d22a3682e9e86aa2d9be53af1e4c9abbbc7'} = 1;
    $dict->{'index'}{'Main Index'}{'4b2e54a6cc5917428b3fb48fb36414a42a5920a6'} = 1;
    $dict->{'index'}{'Main Index'}{'505f1d363a314ef2da488c157a374d6e00c58d57'} = 1;
    $dict->{'index'}{'Main Index'}{'654bcea62270e62de2a28ecc0dd899c8887a69f2'} = 1;
    $dict->{'index'}{'Main Index'}{'78a47d6748c87ad110ef0bead8838a09f26e81a4'} = 1;
    $dict->{'index'}{'Main Index'}{'e7a7a2c704f18d87e723bfffaf5bef04a1dc91dd'} = 1;
    $dict->{'index'}{'Dynamic Site Bootstrapper'}{'2143a746f4f73d9515ca9ab94f3241ca12d17306'} = 1;
    $dict->{'index'}{'RSD'}{'287880a4c3840625053077b6334d91c345acd2e4'} = 1;
    $dict->{'index'}{'Atom Index'}{'b72c5bbb48d9129ea39383e14b98286128952ade'} = 1;
    $dict->{'index'}{'RSS 2.0 Index'}{'81c3335d388f2f69d6311ad4eb6ec344b654684f'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'2214c531eb49879641f1756311e0892f0399a702'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'4fbea20e8866041a59473c23968165499ca58263'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'9c6505c0f818e0f3347797939745f645414b3f47'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'a7851e7e1df743e7697ce987050c6cefe6757295'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'bcb285fdb914d77d1f64f9bdfd93440f3a32720a'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'24a9f9c9aa0ba6d6741dc68e10ed5be406d67df8'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'785529e76220b7ff2028ba216f5845f981ca7d7d'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'82caa3186da19bcea245f653618a0187e2634137'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'94a7cb5c4fe76bdae83d3757b4cf2c3e702df34e'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'ea173dfc883944776432dd24a103cb7b68e097b4'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'fc4cb69b72fbeb8e9cd83886a5ced4f258b8693b'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Message'}{'26eeb357eb88eaf0f750a345b850d59f3f604556'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Message'}{'5c43581ac1a2ce853f4196ba08c6a31b662cd1d1'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Message'}{'8665ead2344f283b1cb7418b9a68dca75876c27b'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Message'}{'951151dc04e6b9ccfdddb9897b3f8c02f3545c6c'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Message'}{'aadde51bddbb40aba343fb9582d4d2cad87fa3e8'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Message'}{'ee85c8685ac1da0841ba3e8a3bf48f6f9665800a'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'30653dc0cb616ae26770cdbd866883ffb2fc0ec9'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'42558b4feda5735b6e9d483fa6765ba094ed6d5e'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'957ca0607d478f8caba7a3e1ba2397d9cd37885f'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'a9d7ebf9d0acd5f2fc8a393591b6b38f09c6b740'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'af1975d66189367b15cec61e342a2b0e23cc9cbd'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'b99d721f630aa2728bea73de47f6cdd87e95ad6c'} = 1;
    $dict->{'popup_image'}{'Uploaded Image Popup Template'}{'f159c35e14a46fe206bf8907bffbb16447cad15c'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'64da0621324294f6c9c3341c31c0c941f35e3b57'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'92ed4e477d08086e5efc2ded4502c08ff98b9f64'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'9d687512b3b2bfc9cb976c903046a579ab887374'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'c41bf5b92366ce227689953f1cae14824cdd54ef'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'e71b31aebef0475e8c6a8e8de0fd47baec1445d9'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'ef9e2dfdf5e99522068456c1871a1d01aaacd2d3'} = 1;
    $dict->{'dynamic_error'}{'Dynamic Pages Error Template'}{'ff3a52b390df5ec6aacdec43112bd047413b4c8c'} = 1;
    $dict->{'index'}{'RSS 1.0 Index'}{'2ff7ed6dc4f509ead2407b6ea3e3f350f28b25bd'} = 1;
    $dict->{'index'}{'Stylesheet'}{'e37a1b39e4c974bf0f3e79dddbf1e855edd0bdca'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'1bd4a4984845a41ad3b8a7303b5b4560daa84752'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'445a90339da5320f442ecc40d7271b574797677a'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'484a36f54c0968b2dbe336845e04307b5e20aa85'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'75936096e7d46e0e3f7c06c9df86f69a12b94768'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'edeed36ce2b0d6d0ff8052f6cf7f4116f39ac1ab'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'f3ef091689d36fc9826200bd55ed21d85a8c53ed'} = 1;
    $dict->{'category'}{'Category Archive'}{'26e7859c15812790454b99de1d3887d0a8e8e6ff'} = 1;
    $dict->{'category'}{'Category Archive'}{'3454326c2552bc1b5bfd1b542ec3ab6c87fb2c43'} = 1;
    $dict->{'category'}{'Category Archive'}{'39096f7db2d393ed66df7de855b9841a90c95485'} = 1;
    $dict->{'category'}{'Category Archive'}{'c0358a683783d625249e9b57075d4d0e6c04cfa7'} = 1;
    $dict->{'category'}{'Category Archive'}{'d178ce949a06690f5c83aa519d801a674430c15c'} = 1;
    $dict->{'category'}{'Category Archive'}{'e81f09062b54027bcd316594c3b945378f0f1347'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'4fcff69ba6afdbcf734ee7c4542cd706a6afdc35'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'551c79d951c8b31a24993a2d9e82fe8b00c2cb3f'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'5a07a70562ecee1aacfb2c2edfd77d1cc7cbf2c6'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'61b03a841e5bb5d2dad7794c068edcaa375853fd'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'855be3df1a0ea28b93bcfc859ed4a9ad723169cc'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'9d01472a423315728d78fcf7e356dbb818ed9ad5'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'0eef136c91c29bb85a2e3679b6edb5cbcdad843d'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'5e894b4ee8fcda2023c7fd38af6d26227f00c59a'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'6a00c296985925588567d31029ad3bb6e018f6ed'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'7a9681c99d268c7c191c373e7e5e7ff7634e7dd3'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'cef4ada361d56ab4387be0c890d0be861ee9bf66'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'fba39a64ad0d8b65344eba4e7f9ca48c8cdb2e3c'} = 1;
    $dict->{'custom'}{'Remember Me'}{'7a644226fb29adec3d541a88d52d792e5672710d'} = 1;

    # 3.2
    $dict->{'index'}{'Main Index'}{'50c83d4f945489528298570a92f2b4ad1afdb1f6'} = 1;
    $dict->{'index'}{'Main Index'}{'c57f03abae67d14e4163535d6e811e274087a4e4'} = 1;
    $dict->{'index'}{'Main Index'}{'6c70ae96c27376919b21bd0e2605cc2aaf3a84b8'} = 1;
    $dict->{'index'}{'Main Index'}{'31ad7c7ebc035652b77e9987fd2d6f203e5fcc8d'} = 1;
    $dict->{'index'}{'Main Index'}{'d03205618f10d0843d61cd664599c2c4c2a85627'} = 1;
    $dict->{'index'}{'Main Index'}{'289070a23482e6e04fbb3f8020c697269ee167cd'} = 1;
    $dict->{'index'}{'Dynamic Site Bootstrapper'}{'e9b325331bd4fce9ca9b544b2a09fa9e01fbd541'} = 1;
    $dict->{'index'}{'RSD'}{'57543f1fd2c6bcb1ed16eaa7d928730a837149d0'} = 1;
    $dict->{'index'}{'Atom Index'}{'5fa1a4c059ce2dcddb526cfa12eae1003be2583b'} = 1;
    $dict->{'index'}{'RSS 2.0 Index'}{'c8b422769d99f8fd21442642d2b79e5a0ee1a85a'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'e9db4c670ff9aff2baea7f609b6db77935ac4282'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'792372eb3c7d207818cea314290369b05c392c3b'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'bff8a874202697b68f9227b71c35ceb11e39a436'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'315b7a74963f553bbd4bd5141052c90520fe6e41'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'653bd8afe0c2763320e7a5f12ceef732a61ed009'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'c95c904e8ee5fd1d7031fe53696c150d7de88956'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'4c46ae1ad45f314b47a5bc6216c36bd91f83a932'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'1a008e9944ae68ecca38581650ab1e877e131755'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'c47383d88a3496506a2c5096933e46f3a95caacc'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'2ced278066ee02eb3f247fb8219af43aad049b1b'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'08d99a3752549f3d03b4a6265f4c9aaa17724e4e'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'bb4801361a4d93826641b184cb9bf2514fb4ca95'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Template'}{'ebd77c22cad2162e95fe9c9e68a1c03aac2aadca'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Template'}{'8cfcdc8a96ec36a8b05851d292f6fba5eb2b4a0d'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Template'}{'19d72988852a13874e6f44ed070b2e1195ceba5d'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Template'}{'3d8028a0374adb4832d828bc729bacc6c2ea2847'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Template'}{'3d08a028a703672bffeadbd914cb2cb1a2e230a8'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Template'}{'b9baeb21b2d210d2e3ef21792a5924b5697b0dde'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'249ed8a29c6a907d952c99b8eb7ce8ff985ede81'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'643bcfa881c379c964423eec1d7d684e75d499e8'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'02f0b905002fe592a0cf112d37564e276b0faa2d'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'b4f20dae1728aa1fe16dd69ea4be6b9e781f502a'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'65b5906a68d564a801c39887e1fee0d2e5f49e2a'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'8f6bcc9c90a8ee868e5968e9a6bd2c32a986b14d'} = 1;
    $dict->{'popup_image'}{'Uploaded Image Popup Template'}{'f159c35e14a46fe206bf8907bffbb16447cad15c'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'1a438795836b35184d43c07071fcb40cf3d8464d'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'9e7b74ac71a7b0dc52b2c0cd90ec79df06ec3f98'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'e8486e7aa71b9421f2d9c344bf10bbdad97f7685'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'8d85f97157a0614e0311ba37f1f2f6873bad21b2'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'eaaa98262408c5fc639d137b59d90948393532f1'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'a38c1b53de303a6d170ef1a5e0cbccccbd2e409a'} = 1;
    $dict->{'dynamic_error'}{'Dynamic Pages Error Template'}{'a966eff35cf5ba521b3cf65b3a864e7928ce545e'} = 1;
    $dict->{'index'}{'Stylesheet'}{'c5fcd0645c518f20229845ae6d1d5f87705561dc'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'56045fcb3935d936148a2885f38b6a78404b4744'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'12bcfe8fbe9d111156791b8c8f3c8749f83dd424'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'a8a589ba1331776f44ed3bec77a786071dd5dc1e'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'77799d5e65d5d122112ac8b88457fa03fe082aec'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'f4b51a67552dbe21883b49225de20ade4ae32796'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'5136216dedc36b2c09c5f8af50ce882500691ec8'} = 1;
    $dict->{'category'}{'Category Archive'}{'224baa825cd0aabad7103d63e658445b8a526832'} = 1;
    $dict->{'category'}{'Category Archive'}{'75bdfb699a3ffed81a694c28a4546eb69a63b048'} = 1;
    $dict->{'category'}{'Category Archive'}{'a7dbf80b657fbb0aa60a7921d4afb28f5e3deab5'} = 1;
    $dict->{'category'}{'Category Archive'}{'151218ebde34c7b519d545b2599cdd7710f94581'} = 1;
    $dict->{'category'}{'Category Archive'}{'8228cc33b01dfc9e56d54ef9244050b5fb4b5edb'} = 1;
    $dict->{'category'}{'Category Archive'}{'2477eaa407ceedf22a5cfd45a712ecfa679bb239'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'2478a6d2a8e2263e08e186c16e628c3308537f7e'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'4481d3e46f181fc48f20deb04cefee32e10b93df'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'5450a02da684d62ce641def899ce2fb1552bd4df'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'12a44b921edd2c334f080d12e12165667ba32bec'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'e9bb249680f91f4ae47dc7f378549dbe96be449b'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'45ff13684d97060048bc6713a998cefc969c8a73'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'804336c28aa4889bf1db400d104ba4ae96c8268b'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'26640fe63e03f3bfc5b7352816f7f1da45a64105'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'c3d91a9921bdab4ea7ce0861add698bdc626fdd2'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'4056479095700a138b9496e8ec213fc98a2d3757'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'be7d64c95bc35412fb2849c66b4c98a00a354302'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'c141038bad4434a325f2addca28d70cd3fc52601'} = 1;
    $dict->{'index'}{'Site JavaScript'}{'353deac26b1e36413f04e168334673cf4ceb0d6e'} = 1;
    $dict->{'index'}{'Site JavaScript'}{'f434f656daffa9d38f2aead9afff9479c3f02370'} = 1;
    $dict->{'index'}{'Site JavaScript'}{'e1d1b06e1d5ea59074ce4c6a3d1d97de5d66fbbc'} = 1;
    $dict->{'index'}{'Site JavaScript'}{'5eda24da316fc1d2fe419b27f0f9271da1a01b04'} = 1;
    $dict->{'index'}{'Site JavaScript'}{'c791e4ff1f6ff8219fe9164f5abfe99caedc097e'} = 1;
    $dict->{'index'}{'Site JavaScript'}{'7d7fee169eff2197beb2d402a760f3983ed215b5'} = 1;

    # 3.3
    $dict->{'index'}{'Main Index'}{'5c40d95bb5dfd4ad1925eab9f09dcdb2f4e4667e'} = 1;
    $dict->{'index'}{'Main Index'}{'6183febd21fd0ee9b401ca55b69318785498da95'} = 1;
    $dict->{'index'}{'Main Index'}{'6e5c86d10ed330c9823d993d316c5253d6cf7675'} = 1;
    $dict->{'index'}{'Main Index'}{'b449bb77af595dad6be852b94f0e4b9405b8dc21'} = 1;
    $dict->{'index'}{'Main Index'}{'bee2ede21b56818fb509437325d083b7812f0355'} = 1;
    $dict->{'index'}{'Main Index'}{'dd5394ca9d1883a9a0addba0a872f7c333fbf72c'} = 1;
    $dict->{'index'}{'Dynamic Site Bootstrapper'}{'e9b325331bd4fce9ca9b544b2a09fa9e01fbd541'} = 1;
    $dict->{'index'}{'RSD'}{'ff390cfb6e179278ed90ed19c46980046cc6ca98'} = 1;
    $dict->{'index'}{'Atom Index'}{'fba75a39812b73ed25b178c6d54a0d88ded749c6'} = 1;
    $dict->{'index'}{'RSS 2.0 Index'}{'28308bc499f2d583cc16451fdee9b4fd0afe7535'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'43fc316f6cbd036a454105a4650633256a7848d2'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'4e7986a28b29f3f9c71b83611c9d7fa801e712f5'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'6967e2b3a874721e415a14974d07bf8d98bb7313'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'6b5420d20e98b218729532bf4cd6f3a1e854b63d'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'aa78a22812234cfedac73007f3174c11e97f5ca7'} = 1;
    $dict->{'index'}{'Master Archive Index'}{'f24a0cd05ce723f528a0cf5b5bdd9fd8e7b122a3'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'02a7238b5cf47492a25346c12403bf4619dde421'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'0d4d33131d2619c282a772a6612ced7b1b756e74'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'1c9ed4be426132a92234b931d08dc293f8821c74'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'39b252fd0d7be06928c0c85f27db9d782a7ad8cc'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'78ade98c2c2c1c302003b75704271edcd9a1a553'} = 1;
    $dict->{'comment_preview'}{'Comment Preview Template'}{'de1b72e1f90d18c8f4d53fc20b058a415229cb34'} = 1;
    $dict->{'search_template'}{'Search Results Template'}{'486ef66c812aff3cea76e0139a119741f378c03e'} = 1;
    $dict->{'search_template'}{'Search Results Template'}{'5c61bb51b5009064ac5d0714c45872e90f962ec7'} = 1;
    $dict->{'search_template'}{'Search Results Template'}{'6083abaa94bc6124d7c81b0e6eb2edece1e2b6e6'} = 1;
    $dict->{'search_template'}{'Search Results Template'}{'7ea885c35f4babd5e5d27dbd29de4883d90b7ad5'} = 1;
    $dict->{'search_template'}{'Search Results Template'}{'a0ae181a5da00e05fecd2da63a93707a60cdf46a'} = 1;
    $dict->{'search_template'}{'Search Results Template'}{'fc747caff630fc6ce954c2167fd76291b32442ee'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Template'}{'203c19dc815ee2a569e999ffe45c9d181938c7e8'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Template'}{'45623af81ada62e96da3a0250677a2a9eb89165a'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Template'}{'af1b078b411608c1624479f9fef21bf23e7035aa'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Template'}{'b0a9c1e1fdb222415252334fc806b1e9cd1e9cd4'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Template'}{'bc45c2305e3dd8980369e30d9b26a6a04a01e439'} = 1;
    $dict->{'comment_pending'}{'Comment Pending Template'}{'e7489716f8a2b0a3858337a37ae8836394f690fd'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'15d7ebb7000b738ac3afd9666874772165962f90'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'a8d3a908dca1d038a2dc8904628d76aa94a289a1'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'b836e718fa1241b2ef68b7da8cfa2fa3918f2dae'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'d742280800194d70a9dc5dc72c774183e5566e32'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'ed3c39c66bb65883520844671d17ba19d408e28c'} = 1;
    $dict->{'comment_error'}{'Comment Error Template'}{'f11e4ab182d6f9d0a0ddeb002e7d84a3296ad9f8'} = 1;
    $dict->{'popup_image'}{'Uploaded Image Popup Template'}{'f159c35e14a46fe206bf8907bffbb16447cad15c'} = 1;
    $dict->{'comments'}{'Comment Listing Template'}{'da39a3ee5e6b4b0d3255bfef95601890afd80709'} = 1;
    $dict->{'dynamic_error'}{'Dynamic Pages Error Template'}{'67f321198052295b9c7090a843a7dd39e1856b5c'} = 1;
    $dict->{'dynamic_error'}{'Dynamic Pages Error Template'}{'74f785030fee43e54aec17495a0d668b32d04400'} = 1;
    $dict->{'dynamic_error'}{'Dynamic Pages Error Template'}{'8263c276766334f5ade678c814c7bc2705e60094'} = 1;
    $dict->{'dynamic_error'}{'Dynamic Pages Error Template'}{'9cf7a4087e15af2c97513d96bc0645c50bb7988c'} = 1;
    $dict->{'dynamic_error'}{'Dynamic Pages Error Template'}{'be2e380cc8806fe7d28722f2edab1b01c5a2e7eb'} = 1;
    $dict->{'dynamic_error'}{'Dynamic Pages Error Template'}{'beb0de4c18f4ccb7c96d0fa8a20443b89fd561e5'} = 1;
    $dict->{'index'}{'Stylesheet'}{'f56b73a0ee479d80cd828351cd0e44d28f1b408c'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'40741d060c976c434bce68f04ba67a3a0ec00b0e'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'49fa2e5810477aca64084689aa424993bc5b6e22'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'7bde4f815ccb8657b0680b10ecda21dc7e48123b'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'89ef8a786feea9b3071c0c0ae4aff3fd6f3882be'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'b2702df25d1b570009bd0a55d2fb9a645343a92c'} = 1;
    $dict->{'archive'}{'Date-Based Archive'}{'b99e0a5026a5863bbaea907cbc11cd51fbd336d5'} = 1;
    $dict->{'category'}{'Category Archive'}{'a1b4c5cbada8123d978bff41286f1703be686cfd'} = 1;
    $dict->{'category'}{'Category Archive'}{'b2d98dbefdd32ff4d4f9d1368dbca4b6518cca2f'} = 1;
    $dict->{'category'}{'Category Archive'}{'c22c57d60ad210ae743c8e427c441a07fd3ab2b7'} = 1;
    $dict->{'category'}{'Category Archive'}{'c274c9b03542f5dfb765ea8540c7185da09fdeac'} = 1;
    $dict->{'category'}{'Category Archive'}{'e3dcd193e33875d0982a28f2c443a27126c10cf1'} = 1;
    $dict->{'category'}{'Category Archive'}{'f6771cefb5e3d8ae7d1bb6bb264171ac843a5df3'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'0a84e63531a74dd4a4ef6b24ea8c2b91ee271e4f'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'2af8713ded4763c22fa49b675d7c46823e860522'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'4f109310012f04b90b5fcf3f3989f573e105da07'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'cd34a24be876fcb4d3791a007fffbb860f719ab1'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'e5997b7781fac409e8b0c5291e62d7110f9f70f2'} = 1;
    $dict->{'individual'}{'Individual Entry Archive'}{'ea8ff046d33b13e184a6554913b1a1ca9f511caf'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'2413900dd7bab6a9f343b3928e87b0e9a002e51f'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'37447d36ad1b21412dbbca4e65e1ab9dd3fc568d'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'467445a45144ab4693afe5dfb9afd2227d030096'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'6091982a5937c8f195fa9f7a088257422b541401'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'976b0a3ab1150ea819179e2142cfa26f04ddeef6'} = 1;
    $dict->{'pings'}{'TrackBack Listing Template'}{'ed00503cfdad65bc0dc6052dcec65156c28e70f5'} = 1;
    $dict->{'index'}{'Site JavaScript'}{'54bca4e2bc0f5dbb60597510fbe61ff4ed003411'} = 1;
    $dict->{'index'}{'Site JavaScript'}{'5f3eed652dcf68046f9b97d3fdce37c775f342d8'} = 1;
    $dict->{'index'}{'Site JavaScript'}{'6f0f45ab3722ceb61975b6f6dd8a520f928764a6'} = 1;
    $dict->{'index'}{'Site JavaScript'}{'c09cf11cc201c9f496d288c70b04ece48e6538b9'} = 1;
    $dict->{'index'}{'Site JavaScript'}{'cb63919ca27db43fb53d8a276330173f38b1711a'} = 1;
    $dict->{'index'}{'Site JavaScript'}{'d9fde44333056883277185fc507eb162d5334bcf'} = 1;
    ];

    $dict;
}

sub default_templates {
    my $app = shift;

    require MT::DefaultTemplates;
    my $tmpl_list = MT::DefaultTemplates->templates;
    return $app->error($app->translate("Error loading default templates.")) unless $tmpl_list;
    $tmpl_list;
}

sub refresh_blog_templates {
    my $plugin = shift;
    my ($app) = @_;

    my $t = time;

    my @id = $app->param('id');
    require MT::Template;
    # logic:
    #    process scope of templates...

    #    load default templates:
    my $tmpl_list = default_templates($app) or return;

    my $dict = default_dictionary();

    my @msg;
    require MT::Blog;
    require MT::Permission;
    require MT::Util;

    foreach my $blog_id (@id) {
        my $blog = MT::Blog->load($blog_id);
        next unless $blog;
        if (!$app->{author}->is_superuser()) {
            my $perms = MT::Permission->load({ blog_id => $blog_id, author_id => $app->{author}->id });
            if (!$perms || (!$perms->can_edit_templates() && !$perms->can_administer_blog())) {
                push @msg, $app->translate("Insufficient permissions to modify templates for weblog '[_1]'", $blog->name());
                next;
            }
        }

        push @msg, $app->translate("Processing templates for weblog '[_1]'", $blog->name);

        foreach my $val (@$tmpl_list) {
            if (!$val->{orig_name}) {
                $val->{orig_name} = $val->{name};
                $val->{name} = $app->translate($val->{name});
                $val->{text} = $app->translate_templatized($val->{text});
            }
            my $orig_name = $val->{orig_name};

            my @ts = MT::Util::offset_time_list($t, $blog_id);
            my $ts = sprintf "%04d-%02d-%02d %02d:%02d:%02d",
                $ts[5]+1900, $ts[4]+1, @ts[3,2,1,0];

            my $terms = {};
            $terms->{blog_id} = $blog_id;
            if ($val->{type} =~ m/^(archive|individual|category|index|custom)$/) {
                $terms->{name} = $val->{name}
            } else {
                $terms->{type} = $val->{type};
            }
            # this should only return 1 template; we're searching
            # within a given blog for a specific type of template (for
            # "system" templates; or for a type + name, which should be
            # unique for that blog.
            my $tmpl = MT::Template->load($terms);
            if ($tmpl) {
                # check for default template text...
                # if it is a default template, then outright replace it
                my $text = $tmpl->text;
                $text =~ s/\s+//g;
                # generate sha1 of $text
                my $digest = MT::Util::perl_sha1_digest_hex($text);
                if (!$dict->{$val->{type}}{$orig_name}{$digest}) {
                    # if it has been customized, back it up to a new tmpl record
                    my $backup = $tmpl->clone;
                    $backup->id(0); # make sure we don't overwrite original
                    $backup->name($backup->name . ' (Backup from ' . $ts . ')');
                    if ($backup->type !~ m/^(archive|individual|category|index|custom)$/) {
                        $backup->type('custom'); # system templates can't be created
                    }
                    $backup->outfile('');
                    $backup->linked_file($tmpl->linked_file);
                    $backup->rebuild_me(0);
                    $backup->build_dynamic(0);
                    $backup->save;
                    push @msg, $app->translate("Refreshing (with <a href=\"?__mode=view&amp;blog_id=[_1]&amp;_type=template&amp;id=[_2]\">backup</a>) template '[_3]'.", $blog_id, $backup->id, $tmpl->name);
                } else {
                    push @msg, $app->translate("Refreshing template '[_1]'.", $tmpl->name);
                }
                # we found that the previous template had not been
                # altered, so replace it with new default template...
                $tmpl->text($val->{text});
                $tmpl->type($val->{type}); # fixes mismatch of types for cases like "archive" => "individual"
                $tmpl->linked_file('');
                $tmpl->save;
            } else {
                # create this one...
                my $tmpl = new MT::Template;
                $tmpl->build_dynamic(0);
                $tmpl->set_values($val);
                $tmpl->blog_id($blog_id);
                $tmpl->save or return $app->error($app->translate("Error creating new template: ") . $tmpl->errstr);
                push @msg, $app->translate("Created template '[_1]'.", $tmpl->name);
            }
        }
    }
    my @msg_loop;
    push @msg_loop, { message => $_ } foreach @msg;

    $app->build_page($plugin->load_tmpl('results.tmpl'), {message_loop => \@msg_loop, return_url => $app->return_uri });
}

sub refresh_individual_templates {
    my $plugin = shift;
    my ($app) = @_;

    require MT::Util;

    my $perms = $app->{perms};
    return $app->error($app->translate("Insufficient permissions for modifying templates for this weblog."))
        unless $perms->can_edit_templates() || $perms->can_administer_blog ||
               $app->{author}->is_superuser();

    my $dict = default_dictionary();

    my $tmpl_list = default_templates($app) or return;

    my $trnames = {};
    my $tmpl_types = {};
    my $tmpls = {};
    foreach my $tmpl (@$tmpl_list) {
        $tmpl->{text} = $app->translate_templatized($tmpl->{text});
        $trnames->{$app->translate($tmpl->{name})} = $tmpl->{name};
        if ($tmpl->{type} !~ m/^(archive|individual|category|index|custom)$/) {
            $tmpl_types->{$tmpl->{type}} = $tmpl;
        } else {
            $tmpls->{$tmpl->{type}}{$tmpl->{name}} = $tmpl;
        }
    }

    my $t = time;

    my @msg;
    my @id = $app->param('id');
    require MT::Template;
    foreach my $tmpl_id (@id) {
        my $tmpl = MT::Template->load($tmpl_id);
        next unless $tmpl;
        my $blog_id = $tmpl->blog_id;

        # FIXME: permission check -- for this blog_id

        my @ts = MT::Util::offset_time_list($t, $blog_id);
        my $ts = sprintf "%04d-%02d-%02d %02d:%02d:%02d",
            $ts[5]+1900, $ts[4]+1, @ts[3,2,1,0];

        my $orig_name = $trnames->{$tmpl->name} || $tmpl->name;
        my $val = $tmpl_types->{$tmpl->type()} ||
                  $tmpls->{$tmpl->type()}{$orig_name};
        if (!$val) {
            push @msg, $app->translate("Skipping template '[_1]' since it appears to be a custom template.", $tmpl->name);
            next;
        }

        my $text = $tmpl->text;
        $text =~ s/\s+//g;

        # generate sha1 of $text
        my $digest = MT::Util::perl_sha1_digest_hex($text);
        if (!$dict->{$tmpl->type}{$orig_name}{$digest}) {
            # if it has been customized, back it up to a new tmpl record
            my $backup = $tmpl->clone;
            $backup->id(0); # make sure we don't overwrite original
            $backup->name($backup->name . ' (Backup from ' . $ts . ')');
            if ($backup->type !~ m/^(archive|individual|category|index|custom)$/) {
                $backup->type('custom'); # system templates can't be created
            }
            $backup->outfile('');
            $backup->linked_file($tmpl->linked_file);
            $backup->rebuild_me(0);
            $backup->build_dynamic(0);
            $backup->save;
            push @msg, $app->translate("Refreshing (with <a href=\"?__mode=view&amp;blog_id=[_1]&amp;_type=template&amp;id=[_2]\">backup</a>) template '[_3]'.", $blog_id, $backup->id, $tmpl->name);
        } else {
            push @msg, $app->translate("Refreshing template '[_1]'.", $tmpl->name);
        }
        # we found that the previous template had not been
        # altered, so replace it with new default template...
        $tmpl->text($val->{text});
        $tmpl->linked_file('');
        $tmpl->save;
    }
    my @msg_loop;
    push @msg_loop, { message => $_ } foreach @msg;

    $app->build_page($plugin->load_tmpl('results.tmpl'), {message_loop => \@msg_loop, return_url => $app->return_uri });
}

1;
