=pod

=head1 LICENSE

  Copyright (c) 1999-2013 The European Bioinformatics Institute and
  Genome Research Limited.  All rights reserved.

  This software is distributed under a modified Apache license.
  For license details, please see

  http://www.ensembl.org/info/about/code_licence.html

=head1 NAME

Bio::EnsEMBL::IO::Parser::Fastq - A FASTQ parser

=head1 DESCRIPTION


=cut

package Bio::EnsEMBL::IO::Parser::Fastq;

use strict;
use warnings;

use Bio::EnsEMBL::Utils::Exception qw/throw/;
use Bio::EnsEMBL::Funcgen::Utils::EFGUtils qw(dump_data);

use base qw/Bio::EnsEMBL::IO::TokenBasedParser/;



sub seek {
    throw("seek method not implemented. Might not be applicable to your file format.");
}

=head2 is_metadata

    Description: Placeholder for user-defined metadata function.
                 Function must determine whether $self->{'current_block'}
                 contains metadata or not.
    Returntype : Boolean

=cut

sub is_metadata {
  my ($self) = @_;

  return($self->{current_block} =~ /^@|^\+/o);
}

=head2 read_metadata

    Description: Placeholder for user-defined metadata function.
                 Function must go through $self-{'current_block'},
                 extract relevant metadata, and store it in 
                 $self->{'metadata'}
    Returntype : Boolean

=cut

sub read_metadata {
  my ($self) = @_;

  my $meta = $self->{current_block};

  if($meta =~ /^@([A-Za-z0-9_.:-]+)\s+/o) {
    $self->{metadata} = $1;
  }
  elsif($meta =~ /^+/) {
    # how do I ignore ?
  }
  else {
    throw("Wrong Metadata format: $meta");
  }
}

=head2 read_record

    Description: Placeholder for user-defined record lexing function.
                 Function must pre-process the data in $self->current block so that it is
                 readily available to accessor methods.
    Returntype : Void 

=cut

sub read_record {
  my ($self) = @_;

  my $seq = self->{current_block} ;
  if($seq =~ /[A-Za-z\n\.~]+/o){
    chomp($seq);
    $seq =~ s/\s//go;
  }
  else{
    throw("Wrong format or unexpected symbol in sequence:\n$seq");
  }

 
}

=head2 open

    Description: Placeholder for user-defined filehandling function.
                 Function must prepare input streams.
    Returntype : True/False on success/failure

=cut

sub open {
  my ($caller, $filename, @other_args) = @_;
  my $class = ref($caller) || $caller;

   my $self = $class->SUPER::open($filename, '^@', undef, @other_args);
  $self->next_block();

  return($self);
}



=head2 close

    Description: Placeholder for user-defined filehandling function.
                 Function must close all open input streams.
    Returntype : True/False on success/failure

=cut

# sub close {
#     throw("close Method not implemented. This is really important");
# }


# =head2 read_block

#     Description: Placeholder for user-defined IO function.
#                  Function must obtain and store the next block (e.g. line) of data from
#                  the file.
#     Returntype : Void 

# =cut

# sub read_block {
#     throw("read_block method not implemented. This is really important");
# }


1;