package eapearson_customInputDev::eapearson_customInputDevClient;

use JSON::RPC::Client;
use POSIX;
use strict;
use Data::Dumper;
use URI;
use Bio::KBase::Exceptions;
my $get_time = sub { time, 0 };
eval {
    require Time::HiRes;
    $get_time = sub { Time::HiRes::gettimeofday() };
};

use Bio::KBase::AuthToken;

# Client version should match Impl version
# This is a Semantic Version number,
# http://semver.org
our $VERSION = "0.1.0";

=head1 NAME

eapearson_customInputDev::eapearson_customInputDevClient

=head1 DESCRIPTION


A KBase module: eapearson_customInputDev


=cut

sub new
{
    my($class, $url, @args) = @_;
    

    my $self = {
	client => eapearson_customInputDev::eapearson_customInputDevClient::RpcClient->new,
	url => $url,
	headers => [],
    };

    chomp($self->{hostname} = `hostname`);
    $self->{hostname} ||= 'unknown-host';

    #
    # Set up for propagating KBRPC_TAG and KBRPC_METADATA environment variables through
    # to invoked services. If these values are not set, we create a new tag
    # and a metadata field with basic information about the invoking script.
    #
    if ($ENV{KBRPC_TAG})
    {
	$self->{kbrpc_tag} = $ENV{KBRPC_TAG};
    }
    else
    {
	my ($t, $us) = &$get_time();
	$us = sprintf("%06d", $us);
	my $ts = strftime("%Y-%m-%dT%H:%M:%S.${us}Z", gmtime $t);
	$self->{kbrpc_tag} = "C:$0:$self->{hostname}:$$:$ts";
    }
    push(@{$self->{headers}}, 'Kbrpc-Tag', $self->{kbrpc_tag});

    if ($ENV{KBRPC_METADATA})
    {
	$self->{kbrpc_metadata} = $ENV{KBRPC_METADATA};
	push(@{$self->{headers}}, 'Kbrpc-Metadata', $self->{kbrpc_metadata});
    }

    if ($ENV{KBRPC_ERROR_DEST})
    {
	$self->{kbrpc_error_dest} = $ENV{KBRPC_ERROR_DEST};
	push(@{$self->{headers}}, 'Kbrpc-Errordest', $self->{kbrpc_error_dest});
    }

    #
    # This module requires authentication.
    #
    # We create an auth token, passing through the arguments that we were (hopefully) given.

    {
	my $token = Bio::KBase::AuthToken->new(@args);
	
	if (!$token->error_message)
	{
	    $self->{token} = $token->token;
	    $self->{client}->{token} = $token->token;
	}
        else
        {
	    #
	    # All methods in this module require authentication. In this case, if we
	    # don't have a token, we can't continue.
	    #
	    die "Authentication failed: " . $token->error_message;
	}
    }

    my $ua = $self->{client}->ua;	 
    my $timeout = $ENV{CDMI_TIMEOUT} || (30 * 60);	 
    $ua->timeout($timeout);
    bless $self, $class;
    #    $self->_validate_version();
    return $self;
}




=head2 validate_custom_input

  $result = $obj->validate_custom_input($workspace, $param1, $param2)

=over 4

=item Parameter and return types

=begin html

<pre>
$workspace is a string
$param1 is a string
$param2 is an eapearson_customInputDev.CustomInputParams
$result is an eapearson_customInputDev.TestResults
CustomInputParams is a reference to a hash where the following keys are defined:
	field1 has a value which is a string
	field2 has a value which is an eapearson_customInputDev.Type0
Type0 is a reference to a hash where the following keys are defined:
	field1 has a value which is a string
	field2 has a value which is a reference to a list where each element is an eapearson_customInputDev.Type1
	field3 has a value which is an eapearson_customInputDev.Type1
Type1 is a reference to a hash where the following keys are defined:
	field1 has a value which is a string
	field2 has a value which is an int
	field3 has a value which is a float
TestResults is a reference to a hash where the following keys are defined:
	status has a value which is a string
	detail has a value which is a string

</pre>

=end html

=begin text

$workspace is a string
$param1 is a string
$param2 is an eapearson_customInputDev.CustomInputParams
$result is an eapearson_customInputDev.TestResults
CustomInputParams is a reference to a hash where the following keys are defined:
	field1 has a value which is a string
	field2 has a value which is an eapearson_customInputDev.Type0
Type0 is a reference to a hash where the following keys are defined:
	field1 has a value which is a string
	field2 has a value which is a reference to a list where each element is an eapearson_customInputDev.Type1
	field3 has a value which is an eapearson_customInputDev.Type1
Type1 is a reference to a hash where the following keys are defined:
	field1 has a value which is a string
	field2 has a value which is an int
	field3 has a value which is a float
TestResults is a reference to a hash where the following keys are defined:
	status has a value which is a string
	detail has a value which is a string


=end text

=item Description



=back

=cut

 sub validate_custom_input
{
    my($self, @args) = @_;

# Authentication: required

    if ((my $n = @args) != 3)
    {
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
							       "Invalid argument count for function validate_custom_input (received $n, expecting 3)");
    }
    {
	my($workspace, $param1, $param2) = @args;

	my @_bad_arguments;
        (!ref($workspace)) or push(@_bad_arguments, "Invalid type for argument 1 \"workspace\" (value was \"$workspace\")");
        (!ref($param1)) or push(@_bad_arguments, "Invalid type for argument 2 \"param1\" (value was \"$param1\")");
        (ref($param2) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument 3 \"param2\" (value was \"$param2\")");
        if (@_bad_arguments) {
	    my $msg = "Invalid arguments passed to validate_custom_input:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	    Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
								   method_name => 'validate_custom_input');
	}
    }

    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
	    method => "eapearson_customInputDev.validate_custom_input",
	    params => \@args,
    });
    if ($result) {
	if ($result->is_error) {
	    Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
					       code => $result->content->{error}->{code},
					       method_name => 'validate_custom_input',
					       data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
					      );
	} else {
	    return wantarray ? @{$result->result} : $result->result->[0];
	}
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method validate_custom_input",
					    status_line => $self->{client}->status_line,
					    method_name => 'validate_custom_input',
				       );
    }
}
 
  
sub status
{
    my($self, @args) = @_;
    if ((my $n = @args) != 0) {
        Bio::KBase::Exceptions::ArgumentValidationError->throw(error =>
                                   "Invalid argument count for function status (received $n, expecting 0)");
    }
    my $url = $self->{url};
    my $result = $self->{client}->call($url, $self->{headers}, {
        method => "eapearson_customInputDev.status",
        params => \@args,
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(error => $result->error_message,
                           code => $result->content->{error}->{code},
                           method_name => 'status',
                           data => $result->content->{error}->{error} # JSON::RPC::ReturnObject only supports JSONRPC 1.1 or 1.O
                          );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(error => "Error invoking method status",
                        status_line => $self->{client}->status_line,
                        method_name => 'status',
                       );
    }
}
   

sub version {
    my ($self) = @_;
    my $result = $self->{client}->call($self->{url}, $self->{headers}, {
        method => "eapearson_customInputDev.version",
        params => [],
    });
    if ($result) {
        if ($result->is_error) {
            Bio::KBase::Exceptions::JSONRPC->throw(
                error => $result->error_message,
                code => $result->content->{code},
                method_name => 'validate_custom_input',
            );
        } else {
            return wantarray ? @{$result->result} : $result->result->[0];
        }
    } else {
        Bio::KBase::Exceptions::HTTP->throw(
            error => "Error invoking method validate_custom_input",
            status_line => $self->{client}->status_line,
            method_name => 'validate_custom_input',
        );
    }
}

sub _validate_version {
    my ($self) = @_;
    my $svr_version = $self->version();
    my $client_version = $VERSION;
    my ($cMajor, $cMinor) = split(/\./, $client_version);
    my ($sMajor, $sMinor) = split(/\./, $svr_version);
    if ($sMajor != $cMajor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Major version numbers differ.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor < $cMinor) {
        Bio::KBase::Exceptions::ClientServerIncompatible->throw(
            error => "Client minor version greater than Server minor version.",
            server_version => $svr_version,
            client_version => $client_version
        );
    }
    if ($sMinor > $cMinor) {
        warn "New client version available for eapearson_customInputDev::eapearson_customInputDevClient\n";
    }
    if ($sMajor == 0) {
        warn "eapearson_customInputDev::eapearson_customInputDevClient version is $svr_version. API subject to change.\n";
    }
}

=head1 TYPES



=head2 TestResults

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
status has a value which is a string
detail has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
status has a value which is a string
detail has a value which is a string


=end text

=back



=head2 Type1

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
field1 has a value which is a string
field2 has a value which is an int
field3 has a value which is a float

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
field1 has a value which is a string
field2 has a value which is an int
field3 has a value which is a float


=end text

=back



=head2 Type0

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
field1 has a value which is a string
field2 has a value which is a reference to a list where each element is an eapearson_customInputDev.Type1
field3 has a value which is an eapearson_customInputDev.Type1

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
field1 has a value which is a string
field2 has a value which is a reference to a list where each element is an eapearson_customInputDev.Type1
field3 has a value which is an eapearson_customInputDev.Type1


=end text

=back



=head2 CustomInputParams

=over 4



=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
field1 has a value which is a string
field2 has a value which is an eapearson_customInputDev.Type0

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
field1 has a value which is a string
field2 has a value which is an eapearson_customInputDev.Type0


=end text

=back



=cut

package eapearson_customInputDev::eapearson_customInputDevClient::RpcClient;
use base 'JSON::RPC::Client';
use POSIX;
use strict;

#
# Override JSON::RPC::Client::call because it doesn't handle error returns properly.
#

sub call {
    my ($self, $uri, $headers, $obj) = @_;
    my $result;


    {
	if ($uri =~ /\?/) {
	    $result = $self->_get($uri);
	}
	else {
	    Carp::croak "not hashref." unless (ref $obj eq 'HASH');
	    $result = $self->_post($uri, $headers, $obj);
	}

    }

    my $service = $obj->{method} =~ /^system\./ if ( $obj );

    $self->status_line($result->status_line);

    if ($result->is_success) {

        return unless($result->content); # notification?

        if ($service) {
            return JSON::RPC::ServiceObject->new($result, $self->json);
        }

        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    elsif ($result->content_type eq 'application/json')
    {
        return JSON::RPC::ReturnObject->new($result, $self->json);
    }
    else {
        return;
    }
}


sub _post {
    my ($self, $uri, $headers, $obj) = @_;
    my $json = $self->json;

    $obj->{version} ||= $self->{version} || '1.1';

    if ($obj->{version} eq '1.0') {
        delete $obj->{version};
        if (exists $obj->{id}) {
            $self->id($obj->{id}) if ($obj->{id}); # if undef, it is notification.
        }
        else {
            $obj->{id} = $self->id || ($self->id('JSON::RPC::Client'));
        }
    }
    else {
        # $obj->{id} = $self->id if (defined $self->id);
	# Assign a random number to the id if one hasn't been set
	$obj->{id} = (defined $self->id) ? $self->id : substr(rand(),2);
    }

    my $content = $json->encode($obj);

    $self->ua->post(
        $uri,
        Content_Type   => $self->{content_type},
        Content        => $content,
        Accept         => 'application/json',
	@$headers,
	($self->{token} ? (Authorization => $self->{token}) : ()),
    );
}



1;
